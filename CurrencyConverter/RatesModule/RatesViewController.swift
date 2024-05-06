//
//  ViewController.swift
//  Currency Converter
//
//  Created by gigaCheh on 28.12.2023.
//
import Foundation
import UIKit

final class RatesViewController: UIViewController {
    
    private var responseLatest: [LatestRatesService.Response] = []
    private var responseSymbols: [SymbolsService.Response] = []
    
    private lazy var symbolsService: SymbolsServiceProtocol = {
        let networkService = NetworkService(tokenProvider: APIToken())
        return SymbolsService.Service(networkService: networkService)
    }()
    
    private lazy var ratesService: LatestServiceProtocol = {
        let networkService = NetworkService(tokenProvider: APIToken())
        
        return LatestRatesService.Service(networkService: networkService)
    }()
    
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.isHidden = true
        return view
    }()
    
    private var loadingView: LoadingView = {
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
    
    
    private var rates: LatestRatesService.Model
    
    init(rates: LatestRatesService.Model) {
        
        self.rates = LatestRatesService.Model(baseCurrencyId: rates.baseCurrencyId, date: rates.date, rates: rates.rates)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var fromLabel: UILabel = {
        
        let labelF = UILabel()
        labelF.text = "From:"
        labelF.textColor = .gray
       
        return labelF
    }()
        
    private lazy var toLabel: UILabel = {
    
        let labelT = UILabel()
        labelT.text = "To:"
        labelT.textColor = .gray
        labelT.numberOfLines = 0
        
        return labelT
    }()
    
    private lazy var flagIm: UIImage = {
        
        let fImage = UIImage()
        
        return fImage
    }()
    
    private lazy var idLabel: UILabel = {
        
        let cLabel = UILabel()
        cLabel.text = "SEK"
        cLabel.font = cLabel.font.withSize(15)
        cLabel.textColor = .white
        
        return cLabel
    }()
        
    private lazy var desLabel: UILabel = {
    
        let dLabel = UILabel()
        dLabel.text = "Swedish krona"
        dLabel.font = dLabel.font.withSize(15)
        dLabel.textColor = .white
        
        return dLabel
    }()
    
    private lazy var sumField: UITextField = {
        var txtName = UITextField()
        txtName.placeholder = "Sum"
        txtName.textColor = .black
        txtName.sizeToFit()
        txtName.borderStyle = .bezel
        
        return txtName
    }()
    
    var dataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = ["Valute 1", "Valute 2", "Valute 3"]
        
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
    }
    
    
}
    
extension RatesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.baseCurrencyId.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RatesCell.id, for: indexPath) as? RatesCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

private extension RatesViewController {

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
    
    
    func setupNavigationBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true

        let editAction = UIAction { _ in
            print("Tapped")
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                           primaryAction: editAction, menu: nil)
        
    }
}
