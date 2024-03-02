//
//  LatestRatesModel.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 05.02.2024.
//

import Foundation

extension LatestRatesService {
    
    struct Model {
        let baseCurrencyId: CurrencyId
        let date: Date
        let rates: [CurrencyId: Double]
    }
}

extension LatestRatesService.Model {
    
    init(response: LatestRatesService.Response) {
        var rates = [CurrencyId: Double]()
        
        response.rates.forEach { key, value in
            rates[key] = value
        }
        
        self.init(
            baseCurrencyId: response.base,
            date: Date(), // TODO: конвертер из строки в Date
            rates: rates
        )
    }
}
