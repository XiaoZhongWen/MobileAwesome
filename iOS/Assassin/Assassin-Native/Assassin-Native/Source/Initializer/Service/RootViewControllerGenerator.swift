//
//  RootViewControllerGenerator.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/8.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import UIKit
import BaseLibrary

class RootViewControllerGenerator {
    var rootViewController: UIViewController? {
        var rootVc: UIViewController? = ZXLoginViewController.init(nibName: "ZXLoginViewController", bundle: .main)
        let userService = UserService.init()
        if let account = userService.activeAccount() {
            if account.username != nil && account.password != nil {
                let appConfigurationService = ApplicationConfigurationService.shared
                if let tabs = appConfigurationService.fetchAppTabs() {
                    let tabGenerator = TabsGenerator.init(tabs: tabs)
                    let tabBarVc = UITabBarController.init()
                    tabBarVc.hidesBottomBarWhenPushed = true
                    tabBarVc.setViewControllers(tabGenerator.tabVcs, animated: true)
                    rootVc = tabBarVc
                }
                AppConfig.shared.fetchConfig(
                domain: Global_Domain,
                bundleId: Global_BundleId,
                productId: Global_ProductId) { result in
                    switch result {
                    case let .success(response):
                        if response.statusCode == 200 {
                            let json = try? response.mapJSON() as? [String: Any]
                            appConfigurationService.checkAndUpdate(configuration: json)
                        }
                        print(response)
                    case let .failure(error):
                        print(error)
                    }
                }
            }
        }
        return rootVc
    }
}
