//
//  LoginViewModel.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/22.
//

import RxSwift
import RxCocoa

class LoginViewModel {
// MARK: - ouput
    /// username验证结果的可观察序列
    let validatedUsername: Driver<ValidationResult>
    
    /// password验证结果的可观察序列
    let validatedPassword: Driver<ValidationResult>
    
    /// 是否可登录的可观察序列
    let signupEnable: Driver<Bool>
    
    /// 登录是否成功的可观察序列
    let signedIn: Driver<Bool>
    
// MARK: - input
    init(input: (
            username: Driver<String>,
            password: Driver<String>,
            loginTaps: Signal<Void>
        ),
        dependency:(
            loginValidateService: ValidationService,
            loginApi: LoginApi
        )
    ) {
        let username = input.username
        let password = input.password
        let loginTaps = input.loginTaps
        let loginApi = dependency.loginApi
        let loginValidateService = dependency.loginValidateService
        
        validatedUsername = username.map { username in
            return loginValidateService.validateUsername(username)
        }
        
        validatedPassword = password.map { password in
            return loginValidateService.validatePassword(password)
        }
        
        signupEnable = Driver.combineLatest(
            validatedUsername,
            validatedPassword
        ) { username, password in
            username.isValid && password.isValid
        }
        
        let usernameAndPassword = Driver.combineLatest(username, password) {
            (username: $0, password: $1)
        }

        signedIn = loginTaps.withLatestFrom(usernameAndPassword).flatMapLatest { pair in
            return loginApi.signup(pair.username, pair.password).asDriver(onErrorJustReturn: false)
        }
    }
    
}
