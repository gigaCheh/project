//
//  NetworkClient.swift
//  Currency Converter
//
//  Created by gigaCheh on 25.01.2024.
//

import Foundation

struct NetworkService {
    
    private let tokenProvider: TokenProviderProtocol
    
    init(tokenProvider: TokenProviderProtocol) {
        self.tokenProvider = tokenProvider
    }
    
    func fetchData<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, ApiClientError>) -> Void) {
        
        var requestWithAuth = request
        
        tokenProvider.addAuthKey(request: &requestWithAuth)
        
        let task = URLSession.shared.dataTask(with: requestWithAuth) { data, respons, error in
            guard let data = data, error == nil else {
                completion(.failure(ApiClientError.empty))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(ApiClientError.deserialize))
            }
        }

        task.resume()
    }
}
