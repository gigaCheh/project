//
//  SymbolsService.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 05.02.2024.
//

import Foundation

/// Name space для моделей и сервисов работы с Symbols
enum SymbolsService { }

protocol SymbolsServiceProtocol {
    func fetchSymbols(completion: Result<[SymbolsService.Symbol], ApiClientError>)
}

/*
final SymbolsService: SymbolsServiceProtocol {
    
    init(...)
    
    func fetchSymbols(completion: @escaping Result<[SymbolsService.Symbol], ApiClientError>) {
        
        UserDefaults()....
        
        let networkService = NetworkService()
        
        networkService.fetchData(request: <#T##URLRequest#>, completion: <#T##(Result<T, ApiClientError>) -> Void#>)
        ...
        ...
        ...
    }
}

final SymbolsServiceMock: SymbolsServiceProtocol {
    
    func fetchSymbols(completion: @escaping Result<[SymbolsService.Symbol], ApiClientError>) {
        completion(.success([]))
    }
}


extension SymbolsService {
    
    
}
*/
