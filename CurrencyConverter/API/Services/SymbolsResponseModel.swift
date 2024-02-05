//
//  SymbolsResponseModel.swift
//  Currency Converter
//
//  Created by gigaCheh on 25.01.2024.
//

extension SymbolsService {
    
    struct Response: Decodable {
        let success: Bool
        let symbols: [String: String]
    }
}
