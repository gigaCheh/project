//
//  APIKey.swift
//  CurrencyConverter
//
//  Created by gigaCheh on 13.02.2024.
//

import Foundation

protocol TokenProviderProtocol {
    var token: String { get }
    
    func addAuthKey(request: inout URLRequest)
}

final class APIToken: TokenProviderProtocol {
    
    let token: String = "ElcLVKjaTaYabso443Aakh6vdzn1PL8v"
    
    func addAuthKey(request: inout URLRequest) {
        request.addValue(token, forHTTPHeaderField: "apikey")
    }
}
