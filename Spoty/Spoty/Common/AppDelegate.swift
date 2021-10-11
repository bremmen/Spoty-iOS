//
//  AppDelegate.swift
//  Spoty
//
//  Created by Bruno Fontes on 30/9/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupInitialController()
        return true
    }

    func setupInitialController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = HomeBuilder.build()
        window?.makeKeyAndVisible()
    }
}

