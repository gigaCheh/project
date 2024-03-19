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
            .init(id: "USD", description: "CDCC"),
            .init(id: "SSS", description: "DFDDF")
            ]
        )
        
        let mainVC = CurrenciesViewController(
            symbols: symbols,
            selectedIds: ["EUR", "USD"],
            isMultipleMode: false
        )
        
        let navController = UINavigationController(rootViewController: mainVC)

        window?.rootViewController = navController

        if !mainWindow.isKeyWindow {
            mainWindow.makeKeyAndVisible()
        }
        
        return true
    }
}
