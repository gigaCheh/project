//
//  CurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 10.03.2024.
//

import Foundation
import UIKit

final class CurrenciesViewController: UIViewController,UITableViewDelegate {

    var myTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        self.myTableView = UITableView(frame: view.bounds, style: .plain)
        self.myTableView.delegate = self
        
        view.addSubview(myTableView)
        
    }
}
