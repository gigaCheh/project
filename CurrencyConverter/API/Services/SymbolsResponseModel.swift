//
//  SymbolsResponseModel.swift
//  Currency Converter
//
//  Created by gigaCheh on 25.01.2024.
//


    
enum SymbolsService {
    
    struct Response: Decodable {
        let success: Bool
        let symbols: [String: String]
    }
    
    struct Symbol: Decodable {  
        let id: String
        let description: String
    }
}

    
