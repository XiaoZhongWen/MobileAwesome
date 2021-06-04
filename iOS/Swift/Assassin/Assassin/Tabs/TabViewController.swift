//
//  TabViewController.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/6/3.
//

import UIKit

enum TabType: Int {
    case Tab_Conversation = 1
    case Tab_Contact = 2
    case Tab_Share = 3
    case Tab_Me = 4
}

class TabViewController: UINavigationController {
    let tab: Tab
    init?(tab: Tab) {
        guard let type = tab.type else {
            return nil
        }
        self.tab = tab
        var rootVc:UIViewController?
        var defaultImage: UIImage?;
        var selectedDefaultImage: UIImage?;
        switch type {
        case TabType.Tab_Conversation.rawValue:
            rootVc = ConversationViewController.init()
            defaultImage = UIImage.init(named: "tab_message_normal")
            selectedDefaultImage = UIImage.init(named: "tab_message_selected")
            break
        case TabType.Tab_Contact.rawValue:
            rootVc = ContactViewController.init()
            defaultImage = UIImage.init(named: "tab_home_normal")
            selectedDefaultImage = UIImage.init(named: "tab_home_selected")
            break
        case TabType.Tab_Share.rawValue:
            rootVc = ShareViewController.init()
            defaultImage = UIImage.init(named: "tab_share_normal")
            selectedDefaultImage = UIImage.init(named: "tab_share_selected")
            break
        case TabType.Tab_Me.rawValue:
            rootVc = MeViewController.init()
            defaultImage = UIImage.init(named: "tab_me_normal")
            selectedDefaultImage = UIImage.init(named: "tab_me_selected")
            break
        default:
            return nil
        }
        
        rootVc?.title = tab.name
        let tabBarItem = TabBarItem.init(title: tab.name, imageUrl: tab.unselIcon, selectedImageUrl: tab.selIcon)
        tabBarItem.image = defaultImage?.withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = selectedDefaultImage?.withRenderingMode(.alwaysOriginal)
        rootVc?.tabBarItem = tabBarItem
        super.init(rootViewController: rootVc!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
