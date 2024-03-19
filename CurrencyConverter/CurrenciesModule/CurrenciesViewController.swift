//
//  CurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 10.03.2024.
//

import Foundation
import UIKit

final class CurrenciesViewController: UIViewController, UITableViewDelegate {

    private var myTableView = UITableView()
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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        self.title = "CCCCC"
        
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        self.myTableView.delegate = self
        
        view.addSubview(myTableView)
        
    }
}
