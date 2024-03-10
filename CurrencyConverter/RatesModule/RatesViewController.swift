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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        /*
        ratesService.fetchRates(symbols: ["USD", "EUR", "JPY", "AUD"], base: "RUB") { [weak self] (result: Result<LatestRatesService.Model, ApiClientError>) in
            print(">>>>")
            print(result)
            //UPDATE()
            print(">>>>")
        }
        
        symbolsService.fetchSymbols { [weak self] (result: Result<SymbolsService.Symbols, ApiClientError>) in
//            print(">>>>")
            print(result)
//            print(">>>>")
        }
        */
    }
}


