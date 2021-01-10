//
//  ViewController.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2020/12/18.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    var disposeBag = DisposeBag()
    
    convenience init(tab: Tab) {
        self.init()
        self.navigationItem.title = tab.name
        self.navigationController?.hidesBottomBarWhenPushed = true
        var imageName = ""
        var selectedImageName = ""
        if let type = tab.type {
            switch type {
            case TabType.messageType.rawValue:
                imageName = "tab_message_normal"
                selectedImageName = "tab_message_selected"
            case TabType.shareType.rawValue:
                imageName = "tab_share_normal"
                selectedImageName = "tab_share_selected"
            case TabType.workType.rawValue:
                imageName = "tab_work_normal"
                selectedImageName = "tab_work_selected"
            case TabType.meType.rawValue:
                imageName = "tab_me_normal"
                selectedImageName = "tab_me_selected"
            default:
                print("type mismatch")
            }
        }
        
        let image = UIImage.init(named: imageName)
        let selectedImage = UIImage.init(named: selectedImageName)
        self.tabBarItem = UITabBarItem.init(title: tab.name, image: image, selectedImage: selectedImage)
        let tabVM = ZXTabViewModel.init(iconUrl: tab.unselIcon, selectedIconUrl: tab.selIcon)
        tabVM.icon?.subscribe(onSuccess: { icon in
            self.tabBarItem.image = icon
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
        tabVM.selectedIcon?.subscribe(onSuccess: { selectedIcon in
            self.tabBarItem.selectedImage = selectedIcon
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
}

