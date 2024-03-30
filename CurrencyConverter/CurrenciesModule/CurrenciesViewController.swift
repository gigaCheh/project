//
//  CurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 10.03.2024.
//

import Foundation
import UIKit

final class CurrenciesViewController: UIViewController {

    //private var myTableView = UITableView()
    private var errorView = UIView()
    private var loadingView = UIView()
    
    private var symbols: SymbolsService.Symbols
    private var selectedIds: Set<CurrencyId>
    private let isMultipleMode: Bool
    
    init(symbols: SymbolsService.Symbols, selectedIds: [CurrencyId], isMultipleMode: Bool) {
        self.symbols = symbols
        self.selectedIds = Set(selectedIds)
        self.isMultipleMode = isMultipleMode
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: view.bounds, style: .grouped)
        table.backgroundColor = .white
        table.dataSource = self
        table.delegate = self
        table.register(CurrenciesCell.self, forCellReuseIdentifier: CurrenciesCell.id)
        return table
    }()
    
    var dataSource: [String] = []
    var items = [String]()
    var selected = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = ["AED - United Arab Emirates Dirham", "AFN - Afghan Afghani", "ALL - Albanian Lek",
                      "AMD - Armenian Dram", "ANG - Netherlands Antillean Guilder", "AOA - Angola Kwanza",
                      "AWG - Aruban Florin", "AUD - Australian Dollar", "ARS - Argentine Peso",
                      "AZN - Azerbaijani Manat", "BAM - Bosnia-Herzegovina Convertible Mark", "BBD - Barbadian Dollar",
                      "BDT - Bangladeshi Taka", "BGN - Bulgarian Lev", "BHD - Bahraini Dinar",
                      "BIF - Burundian Franc", "BMD - Bermudan Dollar", "BND - Brunei Dollar",
                      "BOB - Bolivian Boliviano", "BRL - Brazilian Real", "BSD - Bahamian Dollar",
                      "BTC - Bitcoin", "BTN - Bhutanese Ngultrum", "BWP - Botswanan Pula",]
        
        view.backgroundColor = .green
        view.addSubview(tableView)
        //self.title = "Add currency"
        
        //self.myTableView = UITableView(frame: view.bounds, style: .plain)
        //self.myTableView.delegate = self
        
        //view.addSubview(myTableView)
        setupLayout()
        setupNavigationBar()
    }
}

extension CurrenciesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrenciesCell.id, for: indexPath) as? CurrenciesCell else {
            return UITableViewCell()
        }
        
        let isSelected = selected.contains(indexPath.row)
        
        let model = CurrenciesCell.Model(
            text: dataSource[indexPath.row],
            isSelected: isSelected
        )
        cell.update(model: model)
        return cell
    }
}

extension CurrenciesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //selected.removeAll()
        //selected.insert(indexPath.row)
        //tableView.reloadRows(at: [indexPath], with: .none)
        //tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = "Add Currency"
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        
        headerView.addSubview(label)
        
        return headerView
    }
    
}

private extension CurrenciesViewController {

    func setupLayout() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupNavigationBar() {
        let editAction = UIAction { _ in
            print("Tapped")
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Currencies",
                                                           primaryAction: editAction, menu: nil)
    }
    
}
