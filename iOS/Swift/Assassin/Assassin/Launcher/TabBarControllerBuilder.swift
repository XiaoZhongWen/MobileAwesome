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
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(hexString: ThemeColor)], for: .selected)
        if let tabBarVc = self.tabBarController {
            return tabBarVc
        }
        tabBarController = UITabBarController.init()
        var tabVcs:[UIViewController] = []
        if let tabList = tabs {
            for tab in tabList {
                if let tabVc = TabViewController.init(tab: tab) {
                    tabVcs.append(tabVc)
                }
            }
        }
        tabBarController?.setViewControllers(tabVcs, animated: false)
        return tabBarController!
    }
}
