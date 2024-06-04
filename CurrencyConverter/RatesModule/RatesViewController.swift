//
//  ViewController.swift
//  Currency Converter
//
//  Created by gigaCheh on 28.12.2023.
//
import Foundation
import UIKit

final class RatesViewController: UIViewController {
        
    private let errorView: ErrorView = {
        let view = ErrorView()
        view.isHidden = true
        return view
    }()
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.isHidden = true
        return view
    }()
    
    private lazy var tableView: UITableView = {
        
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(RatesCell.self, forCellReuseIdentifier: RatesCell.id)
        table.backgroundColor = .white
        table.isScrollEnabled = false
        view.addSubview(table)
        
        return table
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let fromLabel: UILabel = {
        
        let labelF = UILabel()
        labelF.text = "From:"
        labelF.textColor = .gray
       
        return labelF
    }()
        
    private let toLabel: UILabel = {
        
        let labelT = UILabel()
        labelT.text = "To:"
        labelT.textColor = .gray
        labelT.numberOfLines = 0
        
        return labelT
    }()
    
    private let flagIm: UIImage = {
        
        let fImage = UIImage()
        
        return fImage
    }()
    
    private let idLabel: UILabel = {
        
        let cLabel = UILabel()
        cLabel.text = "SEK"
        cLabel.font = cLabel.font.withSize(15)
        cLabel.textColor = .white
        
        return cLabel
    }()
        
    private let desLabel: UILabel = {
    
        let dLabel = UILabel()
        dLabel.text = "Swedish krona"
        dLabel.font = dLabel.font.withSize(15)
        dLabel.textColor = .white
        
        return dLabel
    }()
    
    private let sumField: UITextField = {
        var txtName = UITextField()
        txtName.placeholder = "Sum"
        txtName.textColor = .black
        txtName.sizeToFit()
        txtName.borderStyle = .bezel
        
        return txtName
    }()

    private var amount: Double = 0.0
    
    private var latest: LatestRatesService.Model?
    private var symbols: SymbolsService.Symbols?
    private var rateCellModels: [RatesCell]
    
    private let symbolsService: SymbolsServiceProtocol = {
        let networkService = NetworkService(tokenProvider: APIToken())
        return SymbolsService.Service(networkService: networkService)
    }()
    
    private let ratesService: LatestServiceProtocol = {
        let networkService = NetworkService(tokenProvider: APIToken())
        
        return LatestRatesService.Service(networkService: networkService)
    }()

    private var userSettings: UserSettingsProtocol
    
    init(userSettings: UserSettingsProtocol) {
        self.userSettings = userSettings
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Currencies 💱"
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(errorView)
        view.addSubview(loadingView)
        
        showError()
        setupConstraints()
        setupSubviews()
        setupViews()
        setupLayout()
        setupNavigationBar()
        
        initialLoading()
    }
}
    
extension RatesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSettings.toCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RatesCell.id, for: indexPath) as? RatesCell else {
            return UITableViewCell()
        }
        
        let currencyId = userSettings.toCurrencies[indexPath.row]
        
        guard let rate = latest?.rates[currencyId] else {
            return UITableViewCell()
        }
        
        let value = rate * amount
        
        guard let description = symbols?.items.first( where: { $0.id == currencyId } ) else {
            return UITableViewCell()
        }
        
        let image = UIImage(named: currencyId)
        
        let model = RatesCell.Model(
            curName: currencyId,
            curDesc: description,
            curImage: image,
            rate: <#T##String#>,
            rateDescription: <#T##String#>
        )
        
        cell.update(model: model)
        
        return cell
    }
}

private extension RatesViewController {
    
    func initialLoading() {
        showLoader()
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        symbolsService.fetchSymbols { [weak self] (result: Result<SymbolsService.Symbols, ApiClientError>) in
            switch result {
            case let .success(symbols):
                self?.symbols = symbols
            case .failure:
                self?.symbols = nil
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        ratesService.fetchRates(symbols: userSettings.toCurrencies, base: userSettings.fromCurrency) { [weak self] (result: Result<LatestRatesService.Model, ApiClientError>) in
            switch result {
            case let .success(model):
                self?.latest = model
            case .failure:
                self?.latest = nil
            }
            dispatchGroup.leave()
        }
                
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.hideLoadingView()
            self?.processFullUpdate()
        }
    }
    
    func processFullUpdate() {
        guard let symbols = self.symbols, !symbols.items.isEmpty, let latest = self.latest else {
            showError()
            return
        }
        
        updateRatesModel(with: symbols, latest: latest)
        
        tableView.reloadData()
    }

    func setupConstraints() {
        
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        sumField.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        desLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fromLabel.centerXAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            fromLabel.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: -20),
            fromLabel.widthAnchor.constraint(equalToConstant: 80),
            fromLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            toLabel.centerXAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            toLabel.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 65),
            toLabel.widthAnchor.constraint(equalToConstant: 80),
            toLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            sumField.centerXAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            sumField.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            sumField.widthAnchor.constraint(equalToConstant: 50),
            sumField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            idLabel.centerXAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 75),
            idLabel.centerYAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -35),
            idLabel.widthAnchor.constraint(equalToConstant: 50),
            idLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            desLabel.centerXAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            desLabel.centerYAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            desLabel.widthAnchor.constraint(equalToConstant: 100),
            desLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupViews() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            contentView.widthAnchor.constraint(equalToConstant: 370),
            contentView.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func setupSubviews() {
        view.addSubview(contentView)

        contentView.addSubview(fromLabel)
        contentView.addSubview(toLabel)
        contentView.addSubview(sumField)
        contentView.addSubview(idLabel)
        contentView.addSubview(desLabel)
    }
    
    func setupLayout() {
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .yellow
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        [errorView, loadingView].forEach {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }
    
    func showError() {
        view.bringSubviewToFront(errorView)
    }
    
    func showLoader() {
        view.bringSubviewToFront(loadingView)
    }
    
    func hideLoadingView() {
        loadingView.isHidden = true
    }
    
    func updateRatesModel(with symbols: SymbolsService.Symbols, latest: LatestRatesService.Model) {
        rateCellModels.removeAll()
        
        userSettings.toCurrencies.forEach { currencyId in
            
            
            
        }
        
        guard let rate = latest?.rates[currencyId] else {
            
        }
        
        let value = rate * amount
        
        guard let description = symbols?.items.first( where: { $0.id == currencyId } ) else {
            return UITableViewCell()
        }
        
        let image = UIImage(named: currencyId)
        
        let model = RatesCell.Model(
            curName: currencyId,
            curDesc: description,
            curImage: image,
            rate: <#T##String#>,
            rateDescription: <#T##String#>
        )
        
        cell.update(model: model)
    }
    
    func setupNavigationBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true

        let editAction = UIAction { _ in
            print("Tapped")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                           primaryAction: editAction, menu: nil)
    }
}
