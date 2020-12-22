//
//  AppDelegate.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2020/12/18.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import UIKit
import BaseLibrary

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        AppConfig.shared.fetchConfig(domain: "chinamye.com", bundleId: "com.mye.assassin", productID: "8e12d6b3bde4463391a267c7ac44c428") { (response) in
//
//        }
        OpenApi.shared.fetchToken { (response) in
            print(response)
        }
        
        return true
    }
}

