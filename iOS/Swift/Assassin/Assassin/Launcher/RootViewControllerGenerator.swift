//
//  RootViewControllerGenerator.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/11.
//

import UIKit

class RootViewControllerGenerator {
    var rootViewController: UIViewController {
        var rootVc = LoginViewController.init()
        var acc = UserService.shared.activeAccount
        return rootVc
    }

}
