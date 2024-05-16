//
//  AppDelegate.swift
//  Currency Converter
//
//  Created by gigaCheh on 28.12.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainWindow = UIWindow(frame: UIScreen.main.bounds)
        window = mainWindow
        
        let symbols: SymbolsService.Symbols = .init(items: [
            .init(id: "AED", description: "United Arab Emirates Dirham"),
            .init(id: "AFN", description: "Afghan Afghani"),
            .init(id: "ALL", description: "Albanian Lek"),
            .init(id: "AMD", description: "Armenian Dram"),
            .init(id: "BTC", description: "Bitcoin"),
            .init(id: "BTN", description: "Bhutanese Ngultrum"),
            .init(id: "BWP", description: "Botswanan Pula"),            
            ]
        )
        
            /*
        dataSource = [
                      "AMD - Armenian Dram", "ANG - Netherlands Antillean Guilder", "AOA - Angola Kwanza",
                      "AWG - Aruban Florin", "AUD - Australian Dollar", "ARS - Argentine Peso",
                      "AZN - Azerbaijani Manat", "BAM - Bosnia-Herzegovina Convertible Mark", "BBD - Barbadian Dollar",
                      "BDT - Bangladeshi Taka", "BGN - Bulgarian Lev", "BHD - Bahraini Dinar",
                      "BIF - Burundian Franc", "BMD - Bermudan Dollar", "BND - Brunei Dollar",
                      "BOB - Bolivian Boliviano", "BRL - Brazilian Real", "BSD - Bahamian Dollar",
                      "BTC - Bitcoin", "BTN - Bhutanese Ngultrum", "BWP - Botswanan Pula",]
        */
        
        
        //let viewController =
        
        
        let mainVC = TestViewController()
        //let mainVC = RatesViewController(rates: <#T##LatestRatesService.Model#>)
        
        let navController = UINavigationController(rootViewController: mainVC)

        window?.rootViewController = navController

        if !mainWindow.isKeyWindow {
            mainWindow.makeKeyAndVisible()
        }
        
        return true
    }
}
