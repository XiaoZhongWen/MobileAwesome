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
        window?.rootViewController = RootViewControllerGenerator.init().rootViewController
        window?.makeKeyAndVisible()

        NotificationCenter.default.addObserver(forName: NSNotification.Name.init(Login_Status_Notification), object: nil, queue: OperationQueue.main) { notification in
            if let loginStatusType = notification.userInfo?[Login_Status_Key] as? LoginStatusType  {
                if loginStatusType == LoginStatusType.loginSuccess {
                    // switch
                    self.window?.rootViewController = RootViewControllerGenerator.init().rootViewController
                }
            }
        }

        applyTheme()

        return true
    }

    func applyTheme() {
        UINavigationBar.appearance().barTintColor = UIColor.init(hexString: Global_Theme_Color)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

