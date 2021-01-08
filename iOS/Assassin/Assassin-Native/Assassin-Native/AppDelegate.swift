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
import RxSwift
import assassin_flutter_plugin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow.init(frame: UIScreen.main.bounds)
        var rootVc: UIViewController?
        let userService = UserService.init()
        if let account = userService.activeAccount() {
            if let _ = account.username, let _ = account.password {
                // app主页
                AppConfig.shared.fetchConfig(domain: Global_Domain, bundleId: Global_BundleId, productId: Global_ProductId) { result in
                    
                }
            } else {
                // 登录页面
                rootVc = ZXLoginViewController.init(nibName: "ZXLoginViewController", bundle: .main)
            }
        } else {
            rootVc = ZXLoginViewController.init(nibName: "ZXLoginViewController", bundle: .main)
        }
        window?.rootViewController = rootVc
        window?.makeKeyAndVisible()

        NotificationCenter.default.addObserver(forName: NSNotification.Name.init(Login_Status_Notification), object: nil, queue: OperationQueue.main) { notification in
            if let loginStatusType = notification.userInfo?[Login_Status_Key] as? LoginStatusType  {
                if loginStatusType == LoginStatusType.loginSuccess {
                    // switch
                }
            }
        }

        //        let flutterVc = FlutterViewController.init()
        //        flutterVc.setInitialRoute("defaultRoute")
        //        let registrar = flutterVc.registrar(forPlugin: "SwiftAssassinFlutterPlugin")
        //        SwiftAssassinFlutterPlugin.register(with: registrar!)
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

