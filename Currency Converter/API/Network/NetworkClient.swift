//
//  NetworkClient.swift
//  Currency Converter
//
//  Created by gigaCheh on 25.01.2024.
//

import Foundation

struct NetworkService {
    func fetchData<T: Decodable> (
        request: URLRequest, completion: @escaping (Result<T, ApiClientError>) -> Void) {
            URLSession.shared.dataTask(with: request) { data, respons, error in
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
            .resume()
        }
}
