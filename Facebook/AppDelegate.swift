//
//  AppDelegate.swift
//  Facebook
//
//  Created by Muhammad Adam on 4/15/20.
//  Copyright © 2020 MAA. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let viewcontroller = FeedViewController()
        let navigationController = UINavigationController(rootViewController: viewcontroller)
        window?.rootViewController = navigationController
        return true
    }
}

