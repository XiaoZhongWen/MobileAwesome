//
//  ZXMessageController.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/9.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import UIKit
import React
import RxSwift

class ZXMessageController: UIViewController {
    var disposeBag = DisposeBag()
    var channelService: ZXAppConfigurationChannelService?
    
    convenience init(tab: Tab) {
        self.init()
        let image = UIImage.init(named: "tab_message_normal")
        let selectedImage = UIImage.init(named: "tab_message_selected")
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
        initRCTRootView()
    }
}

extension ZXMessageController {
    func initRCTRootView() {
        let jsCodeLocation = URL.init(string: "http://localhost:8081/index.bundle?platform=ios")
        let rootView = RCTRootView.init(bundleURL: jsCodeLocation!,
                                        moduleName: "Assassin_reactnative",
                                        initialProperties: nil,
                                        launchOptions: nil)
        self.view = rootView
    }
}
