//
//  RatesCell.swift
//  CurrencyConverter
//
//  Created by gigaCheh on 06.04.2024.
//

import Foundation
import UIKit

final class RatesCell: UITableViewCell {
    static let id = "RatesCellId"
    
    struct Model {
        let curName: String
        let curDesc: String
        let curImage: UIImage
    }
}
