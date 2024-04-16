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
    
    
    let contentView: UIView = {
        let view = UIView(frame: CGRect(x: 12, y: 210, width: 370, height: 45))
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    private lazy var fromLabel: UILabel = {
        
        let labelF = UILabel()
        labelF.frame = CGRect(x: 0, y: -50, width: 80, height: 50)
        labelF.text = "From:"
        labelF.textColor = .gray
       
        return labelF
    }()
        
    private lazy var toLabel: UILabel = {
    
        let labelT = UILabel()
        labelT.frame = CGRect(x: 0, y: 40, width: 80, height: 50)
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
        cLabel.frame = CGRect(x: 43, y: -15, width: 50, height: 50)
        cLabel.text = "SEK"
        cLabel.font = cLabel.font.withSize(15)
        cLabel.textColor = .white
        
        return cLabel
    }()
        
    private lazy var desLabel: UILabel = {
    
        let dLabel = UILabel()
        dLabel.frame = CGRect(x: 43, y: 10, width: 100, height: 50)
        dLabel.text = "Swedish krona"
        dLabel.font = dLabel.font.withSize(15)
        dLabel.textColor = .white
        
        return dLabel
    }()
    
    private lazy var sumField: UITextField = {
        var txtName = UITextField()
        txtName = UITextField.init(frame: CGRect.init(x: 300, y: 10,
                                                      width: 30, height: 10))
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
        
        contentView.addSubview(fromLabel)
        contentView.addSubview(toLabel)
        contentView.addSubview(sumField)
        contentView.addSubview(idLabel)
        contentView.addSubview(desLabel)
        
        //setupConstraints()
        setupViews()
        setupLayout()
        setupNavigationBar()
    }
    
    
    /*
    func setupConstraints() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 10).isActive = true
        view.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
    }
    */
    func setupViews() {
        view.addSubview(contentView)
        
    }
}
    
extension RatesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        [0,1].filter(<#T##isIncluded: (Int) throws -> Bool##(Int) throws -> Bool#>)
        return 10 // rates.rates.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RatesCell.id, for: indexPath) as? RatesCell else {
            return UITableViewCell()
        }
        
        //let latestRates = rates.baseCurrencyId[indexPath.row]
        
        let model = RatesCell.Model(curName: String, curDesc: <#T##String#>, curImage: UIImage)
        
        return UITableViewCell()
    }
    
    
}

private extension RatesViewController {

    func setupLayout() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .yellow
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
