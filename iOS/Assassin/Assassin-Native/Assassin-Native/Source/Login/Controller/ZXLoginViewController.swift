//
//  ZXLoginViewController.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2020/12/29.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import BaseLibrary

class ZXLoginViewController: UIViewController {
    @IBOutlet private weak var headerView: UIImageView!
    @IBOutlet private weak var usernameTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var usernameLeftButton: UIButton!
    @IBOutlet private weak var passwordLeftButton: UIButton!
    @IBOutlet private weak var passwordValidationLabel: UILabel!
}

extension ZXLoginViewController {
// MARK: - life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // set UI
        setUI()
    }
}

extension ZXLoginViewController {
// MARK: - private methods

    /// 设置UI
    func setUI() {
        usernameTextfield.leftView = usernameLeftButton
        usernameTextfield.leftViewMode = .always
        usernameTextfield.textColor = Login_Textfield_TextColor
        usernameTextfield.layer.borderColor = Login_BorderColor.cgColor
        usernameTextfield.layer.borderWidth = Login_BorderWidth
        usernameTextfield.roundCorners(.allCorners, Login_Textfield_CornerRadius)

        passwordTextfield.leftView = passwordLeftButton
        passwordTextfield.leftViewMode = .always
        passwordTextfield.layer.borderColor = Login_BorderColor.cgColor
        passwordTextfield.layer.borderWidth = Login_BorderWidth
        passwordTextfield.roundCorners(.allCorners, Login_Textfield_CornerRadius)

        loginButton.layer.cornerRadius = Login_Btn_CornerRadius
        let headerSize = headerView.bounds.size.width
        headerView.roundCorners(.allCorners, headerSize / 2)
    }
}
