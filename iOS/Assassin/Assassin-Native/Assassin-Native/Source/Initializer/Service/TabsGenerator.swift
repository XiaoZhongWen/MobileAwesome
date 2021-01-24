//
//  TabsGenerator.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/8.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import UIKit
import Flutter

enum TabType: Int {
    case messageType = 1
    case shareType = 3
    case meType = 4
    case workType = 9
}

class TabsGenerator {
    var tabVcs: [UIViewController]

    init(tabs: [Tab]) {
        tabVcs = Array.init()
        for tab in tabs {
            if let tabType = tab.type {
                var viewController: UIViewController?
                switch tabType {
                case TabType.messageType.rawValue:
                    viewController = ZXMessageController.init(tab: tab)
                case TabType.shareType.rawValue:
                    viewController = ZXShareController.init(tab: tab)
                case TabType.meType.rawValue:
                    viewController = ZXMeController.init(tab: tab)
                case TabType.workType.rawValue:
                    viewController = ZXWorkController.init(tab: tab)
                default:
                    print("type mismatch")
                }
                if let rootVc = viewController {
                    if rootVc.isKind(of: FlutterViewController.self) ||
                        tabType == TabType.messageType.rawValue {
                        tabVcs.append(rootVc)
                    } else {
                        tabVcs.append(UINavigationController.init(rootViewController: rootVc))
                    }
                }
            }
        }
    }
}
