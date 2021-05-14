//
//  RootViewControllerBuilder.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/11.
//

import UIKit

class RootViewControllerBuilder {
    var rootViewController: UIViewController {
        var rootVc: UIViewController = LoginViewController.init()
        let acc = UserService.shared.activeAccount
        if let username = acc?.username, let password = acc?.password {
            if username.count > 0 && password.count > 0 {
                let tabs = ApplicationService.shared.currentAppConfiguration?.currentTabs
                rootVc = TabBarControllerBuilder.init().builder(tabs: tabs)
            }
        }
        return rootVc
    }
}
