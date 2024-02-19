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
    /*
    init(response: LatestRatesService.Response) {
        // TODO: написать конструктор
    }
    */
}
