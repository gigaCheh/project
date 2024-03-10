//
//  SymbolsModel.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 05.02.2024.
//

import Foundation

extension SymbolsService {
    
    struct Symbols {
        let items: [Symbol]
    }
    
    struct Symbol {
        let id: CurrencyId
        let description: String
    }
}

extension SymbolsService.Symbols {
    
    init(response: SymbolsService.Response) {
        var result = [SymbolsService.Symbol]()
        
        response.symbols.forEach { key, value in
            result.append(.init(id: key, description: value))
        }
        self.items = result
    }
}

