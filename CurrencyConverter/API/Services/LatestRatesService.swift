//
//  LatestRatesService.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 05.02.2024.
//
import Foundation
/// Name space для моделей и сервисов работы с LatestRates
enum LatestRatesService { }

protocol LatestServiceProtocol {
    func fetchRates(
        symbols: [CurrencyId],
        base: CurrencyId,
        completion: @escaping (Result<LatestRatesService.Model, ApiClientError>) -> ()
    )
}

extension LatestRatesService {
    
    enum Constansts {
        static let endpoint = "https://api.apilayer.com/exchangerates_data/latest"
    }
    
    final class Service: LatestServiceProtocol {
        
        private let networkService: NetworkService
        
        init(networkService: NetworkService) {
            self.networkService = networkService
        }
        
        func fetchRates(symbols: [CurrencyId], base: CurrencyId, completion: @escaping (Result<LatestRatesService.Model, ApiClientError>) -> ()) {
            guard case let .success(request) = createRequest(symbols: symbols, base: base) else {
                completion(.failure(ApiClientError.request))
                return
            }
            
            networkService.fetchData(request: request) { (result: Result<LatestRatesService.Response, ApiClientError>) in
                switch result {
                case let .failure(error):
                    completion(.failure(error))
                case let .success(response):
                    let model = LatestRatesService.Model(response: response)
                    completion(.success(model))
                }
            }
        }
        
        private func createRequest(symbols: [CurrencyId], base: CurrencyId) -> Result<URLRequest, ApiClientError> {
            let symbolsStr = symbols.joined(separator: ",")
            
            guard var components = URLComponents(string: Constansts.endpoint) else {
                return .failure(ApiClientError.request)
            }
            
            components.queryItems = [
                URLQueryItem(name: "symbols", value: symbolsStr),
                URLQueryItem(name: "base", value: base),
            ]
            
            guard let url = components.url else {
                return .failure(ApiClientError.request)
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            return .success(request)
        }
    }
}
