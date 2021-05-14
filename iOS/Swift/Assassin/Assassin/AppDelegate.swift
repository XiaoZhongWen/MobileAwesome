//
//  AppDelegate.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/10.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let rootVc = RootViewControllerBuilder.init().rootViewController
        self.window?.rootViewController = rootVc
        self.window?.makeKeyAndVisible()

        return true
    }
}

