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


