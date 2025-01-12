//
//  AppDelegate.swift
//  NyanKitty
//
//  Created by Your Name on [Date].
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initUserDefaults()
        return true
    }
}

// MARK: - UserDefaults setup
extension AppDelegate {
    private func initUserDefaults() {
        let defaults = UserDefaults.standard

        // Check if the app is being launched for the first time
        if defaults.object(forKey: "isAppAlreadyLaunchedOnce") == nil {
            let firstTimeLaunchDefaults: [String: Any] = [
                "isAppAlreadyLaunchedOnce": true,
                "actualStage": 1
            ]

            firstTimeLaunchDefaults.forEach {
                defaults.set($0.value, forKey: $0.key)
            }

            defaults.synchronize()
        }
    }
}
