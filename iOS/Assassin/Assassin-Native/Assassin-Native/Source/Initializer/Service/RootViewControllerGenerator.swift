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
                AppConfig.shared.fetchConfig(
                domain: Global_Domain,
                bundleId: Global_BundleId,
                productId: Global_ProductId) { result in
                    print(result)
                }
                rootVc = UITableViewController.init()
            }
        }
        return rootVc
    }
}
