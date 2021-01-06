//
//  AppDelegate.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2020/12/18.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import UIKit
import Flutter
import BaseLibrary
import assassin_flutter_plugin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
//        let flutterVc = FlutterViewController.init()
//        flutterVc.setInitialRoute("defaultRoute")
//        let registrar = flutterVc.registrar(forPlugin: "SwiftAssassinFlutterPlugin")
//        SwiftAssassinFlutterPlugin.register(with: registrar!)

        let loginVc = ZXLoginViewController.init(nibName: "ZXLoginViewController", bundle: .main)

        window?.rootViewController = loginVc
        window?.makeKeyAndVisible()
//        AppConfig.shared.fetchConfig(domain: "cike.com", bundleId: "com.mye.assassin", productId: "8e12d6b3bde4463391a267c7ac44c428") { (result) in
//            switch result {
//            case let .success(response):
//                print(response)
//            case let .failure(error):
//                print(error)
//            }
//        }
        return true
    }
}

