//
//  LoginViewController.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/11.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: ViewController {
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

// MARK: - life cycle
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
        
        self.bindVM()
    }
}

// MARK: - private method
extension LoginViewController {
    func bindVM() {
        let loginService = LoginService.init()
        let validataService = LoginValidateService.init()
        let loginViewModel = LoginViewModel.init(input:
                                                    (username: self.userIdTxtField.rx.text.orEmpty.asDriver(),
                                                     password: self.pwdTxtField.rx.text.orEmpty.asDriver(),
                                                     loginTaps: self.loginBtn.rx.tap.asSignal()),
                                                 dependency:
                                                    (loginValidateService: validataService,
                                                     loginApi: loginService))

        loginViewModel.signupEnable.drive(onNext: { enable in
            self.loginBtn.isUserInteractionEnabled = enable
            if enable {
                self.loginBtn.alpha = 1.0
            } else {
                self.loginBtn.alpha = 0.5
            }
        }).disposed(by: disposeBag)

        loginViewModel.signedIn.drive(onNext: { signedIn in
            print(signedIn)
        }).disposed(by: disposeBag)
    }
}

// MARK: - initialize
extension LoginViewController {
    func initialize() {
        imgView.image = UIImage.init(named: "login_icon")?.withCorner(CGFloat(Login_Icon_Size) * 0.5)
        userIdTxtField.placeholder = Account_zh
        pwdTxtField.placeholder = Pwd_zh
        loginBtn.setTitle(Login_zh, for: .normal)

        userIdTxtField.font = UIFont.systemFont(ofSize: FontSize_Level_3)
        pwdTxtField.font = UIFont.systemFont(ofSize: FontSize_Level_3)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: FontSize_Level_4)
        loginBtn.isUserInteractionEnabled = false
        loginBtn.alpha = 0.5

        userIdTxtField.backgroundColor = BackgroundColor
        pwdTxtField.backgroundColor = BackgroundColor

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
