//
//  ViewController.swift
//  Currency Converter
//
//  Created by gigaCheh on 28.12.2023.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    
    private var responseLatest: [LatestRatesService.Response] = []
    private var responseSymbols: [SymbolsService.Response] = []
    private let networkService = NetworkService()
    private let key = APIToken()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlSymbols = "https://api.apilayer.com/exchangerates_data/symbols"
        var requestSymbols = URLRequest(url: URL(string: urlSymbols)!, timeoutInterval: Double.infinity)
        requestSymbols.httpMethod = "GET"
        requestSymbols.addValue(key.token, forHTTPHeaderField: "apikey")

        
        let urlLatest = "https://api.apilayer.com/exchangerates_data/latest?symbols=RUB,EUR&base=USD"
        var requestLatest = URLRequest(url: URL(string: urlLatest)!, timeoutInterval: Double.infinity)
        
        requestLatest.httpMethod = "GET"
        requestLatest.addValue(key.token, forHTTPHeaderField: "apikey")

        
        networkService.fetchData(request: requestSymbols) { (result: Result<[SymbolsService.Response],ApiClientError>) in
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.responseSymbols = data
                }
            case .failure(let error):
                print("Error downloading data:", error)
            }
        }
        
        
        networkService.fetchData(request: requestLatest) { (result: Result<[LatestRatesService.Response],ApiClientError>) in
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.responseLatest = data
                }
            case .failure(let error):
                print("Error downloading data:", error)
            }
        }
    }
            }
        /*
        let taskLatest = URLSession.shared.dataTask(with: requestLatest) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
            
            do {

                let decoder = JSONDecoder()
                let model = try decoder.decode(LatestRatesService.Response.self, from: data)
                print("JSON decode success: \(model)")
            } catch {
                print("Failing to decode JSON")
            }
        }

        taskLatest.resume()
         */
        
    
        /*
        let taskSymbols = URLSession.shared.dataTask(with: requestSymbols) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
//          print(String(data: data, encoding: .utf8)!)
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(SymbolsService.Response.self, from: data)
                print("JSON decode success : \(model)")
            } catch {
                print("Failing to decode JSON")
            }
        }

        taskSymbols.resume()
        
    }


}
*/

