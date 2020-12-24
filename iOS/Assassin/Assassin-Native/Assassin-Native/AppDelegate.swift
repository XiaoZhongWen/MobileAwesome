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
        AppConfig.shared.fetchConfig(domain: "cike.com", bundleId: "com.mye.assassin", productID: "8e12d6b3bde4463391a267c7ac44c428") { (result) in
            switch result {
            case let .success(data):
                print(String.init(data: data, encoding: .utf8))
            case let .failure(error):
                print(error)
            }
        }
        
        return true
    }
}

