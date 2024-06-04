//
//  UserSettings.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 17.05.2024.
//

import Foundation

protocol UserSettingsProtocol {
    var fromCurrency: CurrencyId { get set }
    var toCurrencies: [CurrencyId] { get set }
}

final class UserSettings: UserSettingsProtocol {
        
    private let defaults = UserDefaults.standard
    
    var fromCurrency: CurrencyId {
        get {
            return defaults.string(forKey: Constansts.fromCurrencyKey) ?? Constansts.defaultFrom
        }
        set {
            defaults.set(newValue, forKey: Constansts.fromCurrencyKey)
        }
    }
    
    var toCurrencies: [CurrencyId] {
        get {
            return defaults.stringArray(forKey: Constansts.toCurrenciesKey) ?? Constansts.defaultTo
        }
        set {
            defaults.set(newValue, forKey: Constansts.toCurrenciesKey)
        }
    }
}

private extension UserSettings {
    enum Constansts {
        static let defaultFrom = "USD"
        static let defaultTo = ["EUR", "GBP"]
        static let fromCurrencyKey = "fromCurrency"
        static let toCurrenciesKey = "toCurrencies"
    }
}
