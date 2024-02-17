//
//  NetworkManager(URLRequest).swift
//  CurrencyConverter
//
//  Created by gigaCheh on 17.02.2024.
//

import Foundation

enum HttpMethod : String {
    case get = "GET"
}


class NetworkManager {
    
    
    static let shared = NetworkManager()
    
    private let baseURL: URL
    private let tokenProvider: TokenProvider
    
    private init() {
        self.baseURL = URL(string: "наш URL")!
        self.tokenProvider = TokenProvider()
    }
    
    func createRequest(for endpoint: ApiEndpoint) -> URLRequest? {
        guard let url = createURL(for: endpoint) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(tokenProvider.token)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 30
        
        return request
    }
    
    private func createURL(for endpoint: ApiEndpoint) -> URL? {
        
        //создать url для нашего endpoint
        
    }
    
    return nil
}

protocol TokenProvider {
    var token: String { get }
}

enum ApiEndpoint {
    case ...
    
    var httpMethod: HttpMethod {
        //определить метод http на основе endpoint
        
        
         switch self {
         case .getRates:
         return .get
         }
         
    }
    
}

