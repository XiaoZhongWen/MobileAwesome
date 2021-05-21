//
//  LoginViewController.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/11.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    private let imgView: UIImageView
    private let userIdTxtField: BaseTextField
    private let pwdTxtField: BaseTextField
    private let loginBtn: CornerButton

    init() {
        imgView = UIImageView.init()
        userIdTxtField = BaseTextField.init()
        pwdTxtField = BaseTextField.init()
        loginBtn = CornerButton.init(cornerRadius: CGFloat(Radius))
        super.init(nibName: nil, bundle: nil)
        self.initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Mark: - life cycle
extension LoginViewController {
    override func viewDidLoad() {
        self.view.addSubview(self.imgView)
        self.view.addSubview(self.userIdTxtField)
        self.view.addSubview(self.pwdTxtField)
        self.view.addSubview(self.loginBtn)

        self.imgView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(Login_Icon_Top_Margin)
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSize.init(width: Login_Icon_Size, height: Login_Icon_Size))
        }

        self.userIdTxtField.snp_makeConstraints { (make) in
            make.top.equalTo(self.imgView.snp_bottom).offset(Login_UserIdTxtField_Top_Margin)
            make.centerX.equalTo(self.view)
            make.left.equalTo(self.view).offset(Login_TextField_Margin)
            make.right.equalTo(self.view).offset(-Login_TextField_Margin)
            make.height.equalTo(Login_TextField_Height)
        }

        self.pwdTxtField.snp_makeConstraints { (make) in
            make.top.equalTo(self.userIdTxtField.snp_bottom).offset(Login_PwdTxtField_Top_Margin)
            make.left.right.equalTo(self.userIdTxtField)
            make.height.equalTo(Login_TextField_Height)
        }

        self.loginBtn.snp_makeConstraints { (make) in
            make.top.equalTo(self.pwdTxtField.snp_bottom).offset(Login_TextField_Margin)
            make.left.right.equalTo(self.pwdTxtField)
            make.height.equalTo(Login_Btn_Height)
        }
    }
}

// Mark: - initialize
extension LoginViewController {
    func initialize() {
        imgView.image = UIImage.init(named: "login_icon")?.withCorner(CGFloat(Login_Icon_Size) * 0.5)
        userIdTxtField.placeholder = Account_zh
        pwdTxtField.placeholder = Pwd_zh
        loginBtn.setTitle(Login_zh, for: .normal)

        userIdTxtField.font = UIFont.systemFont(ofSize: FontSize_Level_3)
        pwdTxtField.font = UIFont.systemFont(ofSize: FontSize_Level_3)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: FontSize_Level_4)

        let phoneNumberIcon = UIImage.init(named: "icon_phonenumber")
        let phoneNumberBtn = UIButton.init(type: .custom)
        phoneNumberBtn.setImage(phoneNumberIcon, for: .normal)
        phoneNumberBtn.sizeToFit()
        
        let pwdIcon = UIImage.init(named: "icon_password")
        let pwdBtn = UIButton.init(type: .custom)
        pwdBtn.setImage(pwdIcon, for: .normal)
        pwdBtn.sizeToFit()

        userIdTxtField.leftViewMode = .always
        pwdTxtField.leftViewMode = .always
        userIdTxtField.leftView = phoneNumberBtn
        pwdTxtField.leftView = pwdBtn

        loginBtn.backgroundColor = UIColor.init(hexString: ThemeColor)
    }
}
