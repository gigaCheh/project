//
//  ViewController.swift
//  Currency Converter
//
//  Created by gigaCheh on 28.12.2023.
//
import Foundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let urlLatest = "https://api.apilayer.com/exchangerates_data/latest?symbols=USD,EUR&base=USD"
        var requestLatest = URLRequest(url: URL(string: urlLatest)!, timeoutInterval: Double.infinity)
        
        requestLatest.httpMethod = "GET"
        requestLatest.addValue("ElcLVKjaTaYabso443Aakh6vdzn1PL8v", forHTTPHeaderField: "apikey")

        let taskLatest = URLSession.shared.dataTask(with: requestLatest) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
            do {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy"
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                let decoded = try decoder.decode([CurrencyConversion].self, from: data)
                print("JSON decode success")
            } catch {
                print("Failing to decode JSON")
            }
        }

        taskLatest.resume()
        
        
        let urlSymbols = "https://api.apilayer.com/exchangerates_data/symbols"
        var requestSymbols = URLRequest(url: URL(string: urlSymbols)!,timeoutInterval: Double.infinity)
        requestSymbols.httpMethod = "GET"
        requestSymbols.addValue("ElcLVKjaTaYabso443Aakh6vdzn1PL8v", forHTTPHeaderField: "apikey")

        let taskSymbols = URLSession.shared.dataTask(with: requestSymbols) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Success].self, from: data)
                print("JSON decode success")
            } catch {
                print("Failing to decode JSON")
            }
        }

        taskSymbols.resume()
    }


}

