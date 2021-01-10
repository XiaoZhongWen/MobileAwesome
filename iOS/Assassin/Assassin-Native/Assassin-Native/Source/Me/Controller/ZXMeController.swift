//
//  ZXMeController.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/9.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import UIKit
import RxSwift
import Flutter
import assassin_flutter_plugin

class ZXMeController: FlutterViewController {
    var disposeBag = DisposeBag()
    
    convenience init(tab: Tab) {
        self.init()
        self.setInitialRoute("defaultRoute")
        let registrar = self.registrar(forPlugin: "SwiftAssassinFlutterPlugin")
        SwiftAssassinFlutterPlugin.register(with: registrar!)
        self.navigationItem.title = tab.name
        self.navigationController?.hidesBottomBarWhenPushed = true
        let image = UIImage.init(named: "tab_me_normal")
        let selectedImage = UIImage.init(named: "tab_me_selected")
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
}
