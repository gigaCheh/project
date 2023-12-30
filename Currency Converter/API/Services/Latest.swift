//
//  Latest.swift
//  Currency Converter
//
//  Created by gigaCheh on 30.12.2023.
//

import Foundation

struct CurrencyConversion: Decodable {
    var base: String
    var date: Date
    var exchangeRates: [ExchangeRate]{
        return rates.values
    }
    private var rates: ExchangeRate.ListRate
}

struct ExchangeRate: Decodable {
    var currency: String
    var rate: Double
}

private extension ExchangeRate {
    struct ListRate: Decodable {
        let values: [ExchangeRate]

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let dictionary = try container.decode([String : Double].self)

            values = dictionary.map { key, value in
                ExchangeRate(currency: String(key), rate: value)
            }
        }
    }
}
