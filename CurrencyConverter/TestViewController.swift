//
//  TestViewController.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 16.04.2024.
//

import UIKit

final class TestViewController: UIViewController {
    
    private let testView = LoadingView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = testView
    }
    
    /*
    override func viewDidLoad() {
         super.viewDidLoad()
         
         let customCell = RatesCell()
         customCell.frame = CGRect(x: 0, y: 300, width: view.frame.width, height: 100)
         
         view.addSubview(customCell)
     }
     */
}

