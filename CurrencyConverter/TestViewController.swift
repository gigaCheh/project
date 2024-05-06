//
//  TestViewController.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 16.04.2024.
//

import UIKit

final class TestViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(RatesCell.self, forCellReuseIdentifier: RatesCell.id)
        table.backgroundColor = .white
        table.isScrollEnabled = false
        return table
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
}

extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RatesCell.id, for: indexPath) as? RatesCell else {
            return UITableViewCell()
        }
            
        let model = RatesCell.Model(
            curName: "GBP",
            curDesc: "Pound sterling sterling sterling sterling sterling",
            curImage: UIImage(named: "AED"),
            rate: "3242.492057",
            rateDescription: "1 GBP = 11.766905 SEK"
        )
        
        cell.update(model: model)
        return cell
    }
  
}
