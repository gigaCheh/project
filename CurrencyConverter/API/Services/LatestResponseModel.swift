//
//  LatestResponseModel.swift
//  Currency Converter
//
//  Created by gigaCheh on 25.01.2024.
//

        
import Foundation


enum LatestRatesService {
        
    struct Response: Decodable {
        let base: String
        let date: String
        let rates: [String: Double]
    }

}
    
   
