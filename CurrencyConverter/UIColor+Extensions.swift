//
//  UIColor+Extensions.swift
//  CurrencyConverter
//
//  Created by Dmitriy Mirovodin on 16.04.2024.
//

import UIKit

extension UIColor {
    
    static func random() -> UIColor {
        return UIColor.rgb(CGFloat.random(in: 0..<256), green: CGFloat.random(in: 0..<256), blue: CGFloat.random(in: 0..<256))
    }
    
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
