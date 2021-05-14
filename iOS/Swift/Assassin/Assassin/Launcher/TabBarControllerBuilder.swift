//
//  TabBarControllerBuilder.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/12.
//

import UIKit

class TabBarControllerBuilder {

    private var tabBarController: UITabBarController?

    func builder(tabs: [Tab]?) -> UITabBarController {
        if let tabBarVc = self.tabBarController {
            return tabBarVc
        }
        tabBarController = UITabBarController.init()
        return tabBarController!
    }
}
