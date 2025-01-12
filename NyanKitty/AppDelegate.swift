//
//  AppDelegate.swift
//  NyanKitty
//
//  Created by Jakob Buszka on 1/11/25.
//  Copyright © 2025 Horváth Balázs. All rights reserved.
//


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let gameViewController = GameViewController()
        window?.rootViewController = gameViewController
        window?.makeKeyAndVisible()
        return true
    }
}