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
    func fetchRates(completion: @escaping (Result<LatestRatesService.Model,
                    ApiClientError>) -> ())
}


extension LatestRatesService {
    
    enum Constansts {
        static let endpoint = "https://api.apilayer.com/exchangerates_data/latest?symbols=RUB,EUR&base=USD"
    }
    
    final class Service: LatestServiceProtocol {
        
        init(tokenProvider: TokenProviderProtocol) {
            
        }
        
        func fetchRates(completion: @escaping (Result<LatestRatesService.Model, ApiClientError>) -> ()) {
            guard case let .success(request) = createRequest() else {
                completion(.failure(ApiClientError.request))
            }
            
            let networkClient = NetworkService(tokenProvider: tokenProvider)
            
            networkClient.fetchData(request: request) { (result: Result<LatestRatesService.Response, ApiClientError>) in
                switch result {
                case let .failure(error):
                    completion(.failure(error))
                case let .success(response):
                    let model = LatestRatesService.Model(response: response)
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
