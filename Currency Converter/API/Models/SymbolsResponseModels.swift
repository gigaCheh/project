//
//  Symbols.swift
//  Currency Converter
//
//  Created by gigaCheh on 30.12.2023.
//

enum SymbolsService {
    
    struct Response: Decodable {
        let success: Bool
        let symbols: [String: String]
    }
    
    struct Symbol: Decodable { // Business logic !!!
        let id: String
        let description: String
    }
}


/*
private extension Symbols {
    struct ListValute: Decodable {
        let property: [Symbols]
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let dictionary = try container.decode([String:String].self)
            
            property = dictionary.map { key, value in
                Symbols(abbreviation: String(key), valute: String(value))
            }
        }
    }
}
*/
