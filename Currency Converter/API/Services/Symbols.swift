//
//  Symbols.swift
//  Currency Converter
//
//  Created by gigaCheh on 30.12.2023.
//

import Foundation

struct Success: Decodable {
    var success: Bool
    var symbols: [Symbols]
}

struct Symbols: Decodable {
    var abbreviation: String
    var valute: String
}

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
