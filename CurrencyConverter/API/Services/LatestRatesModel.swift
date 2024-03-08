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
        
        let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let date = dateFormatter.date(from: response.date) else {
                    fatalError("Не удалось преобразовать строку даты в объект Date")
                }
        
        self.init(
            baseCurrencyId: response.base,
            date: date, // TODO: конвертер из строки в Date
            rates: rates
        )
    }
}


extension DateFormatter {
    static let DDMMYYYYHHMM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = TimeZone.ReferenceType.default
        
        return formatter
    }()
}

