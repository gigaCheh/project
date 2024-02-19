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
        
        init(tokenProvider: TokenProviderProtocol) {
            
        }
     
        func fetchSymbols(completion: @escaping (Result<SymbolsService.Symbols, ApiClientError>) -> ()) {

            guard case let .success(request) = createRequest() else {
                completion(.failure(ApiClientError.request))
            }
            
            let networkClient = NetworkService(tokenProvider: tokenProvider)
            
            networkClient.fetchData(request: request) { (result: Result<SymbolsService.Response, ApiClientError>) in
                switch result {
                case let .failure(error):
                    completion(.failure(error))
                case let .success(response):
                    let model = SymbolsService.Symbols(response: response)
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

