//
//  CurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 10.03.2024.
//

import Foundation
import UIKit

final class CurrenciesViewController: UIViewController {

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
        table.tableFooterView = UIView()
        table.sectionFooterHeight = 0
        table.backgroundColor = .white
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        table.dataSource = self
        table.delegate = self
        table.register(CurrenciesCell.self, forCellReuseIdentifier: CurrenciesCell.id)
        return table
    }()
    
    private var symbols: SymbolsService.Symbols
    private var selectedIds: Set<CurrencyId>
    private let isMultipleMode: Bool
    
    init(symbols: SymbolsService.Symbols, selectedIds: [CurrencyId], isMultipleMode: Bool) {
        
        self.symbols = SymbolsService.Symbols(items: symbols.items.sorted(by: { s1, s2 in
            return s1.id < s2.id
        }))
        
        self.selectedIds = Set(selectedIds)
        self.isMultipleMode = isMultipleMode
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = isMultipleMode ? "Add Currency" : "Select Base Currency"
        
        view.backgroundColor = .green
        view.addSubview(tableView)
        view.addSubview(errorView)
        view.addSubview(loadingView)
        
        //view.bringSubviewToFront(errorView)
        setupLayout()
        setupNavigationBar()
    }
}

extension CurrenciesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symbols.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrenciesCell.id, for: indexPath) as? CurrenciesCell else {
            return UITableViewCell()
        }
        
        let currency = symbols.items[indexPath.row]
                
        let isSelected = selectedIds.contains(currency.id)
        
        let model = CurrenciesCell.Model(
            text: currency.id + " - " + currency.description,
            isSelected: isSelected
        )
        cell.update(model: model)
        return cell
    }
}

extension CurrenciesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currency = symbols.items[indexPath.row]
        
        if isMultipleMode {
            if selectedIds.contains(currency.id) {
                selectedIds.remove(currency.id)
            }
        } else {
            selectedIds.removeAll()
        }
        
        selectedIds.insert(currency.id)
        
        tableView.reloadData()
    }
}

private extension CurrenciesViewController {
    
    func setupLayout() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        errorView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        [tableView, errorView, loadingView].forEach {
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }
    
    func setupNavigationBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
        
    }
}
