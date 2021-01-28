//
//  SystemInterfaceProvider.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/26.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import Foundation

@objc(SystemInterfaceProvider)
class SystemInterfaceProvider: NSObject {
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc(hideTabBar:)
    func hideTabBar(isHide: Bool) {
        DispatchQueue.main.async {
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                if let tabBarVc = rootViewController as? UITabBarController {
                    if tabBarVc.tabBar.isHidden != isHide {
                        tabBarVc.tabBar.isHidden = isHide
                    }
                }
            }
        }
    }
}
