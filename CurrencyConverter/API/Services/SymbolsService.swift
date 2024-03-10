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
    func fetchSymbols(completion: @escaping (Result<SymbolsService.Symbols, ApiClientError>) -> ())
}

extension SymbolsService {
    
    enum Constansts {
        static let endpoint = "https://api.apilayer.com/exchangerates_data/symbols"
    }

    final class Service: SymbolsServiceProtocol {
        
        private let networkService: NetworkService
        private var chachedSymbols: SymbolsService.Symbols?
        
        init(networkService: NetworkService) {
            self.networkService = networkService
        }
     
        func fetchSymbols(completion: @escaping (Result<SymbolsService.Symbols, ApiClientError>) -> ()) {
            if let chachedSymbols = chachedSymbols {
                completion(.success(chachedSymbols))
                return
            }
            
            guard case let .success(request) = createRequest() else {
                completion(.failure(ApiClientError.request))
                return
            }
            
            networkService.fetchData(request: request) { [weak self] (result: Result<SymbolsService.Response, ApiClientError>) in
                switch result {
                case let .failure(error):
                    completion(.failure(error))
                case let .success(response):
                    let model = SymbolsService.Symbols(response: response)
                    self?.chachedSymbols = model
                    completion(.success(model))
                }
            }
        }
        
        private func createRequest() -> Result<URLRequest, ApiClientError> {
            guard let url = URL(string: Constansts.endpoint) else {
                return .failure(ApiClientError.request)
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            return .success(request)
        }
    }
}

extension SymbolsService {
    
    final class ServiceDemoData: SymbolsServiceProtocol {

        private let demoData: SymbolsService.Symbols = .init(
            items: [Symbol(id: "Robux", description: "Roblox")]
        )
        
        func fetchSymbols(completion: @escaping (Result<SymbolsService.Symbols, ApiClientError>) -> ()) {
            completion(.success(demoData))
        }
    }
}
