//
//  ZXLoginViewModel.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2020/12/29.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation
import RxSwift
import BaseLibrary
import Moya

class ZXLoginViewModel {
    let loginEnable: Observable<Bool>
    let loginStatus: Observable<Result<Moya.Response, MoyaError>>

    init(input: (
            username: Observable<String>,
            password: Observable<String>,
            loginTaps: Observable<Void>),
         validationService: ZXValidationService) {
        let validatedUsername = input.username.flatMapLatest { (username: String) -> Observable<Bool> in
            let isValid = !username.isEmpty
            return .just(isValid)
        }

        let validatedPassword = input.password.flatMapLatest({ password -> Observable<ZXValidationResult> in
            return validationService.validatePassword(password: password)
        })

        loginEnable = Observable.combineLatest(validatedUsername, validatedPassword) { username, password in
            return username && password.isValid
        }

        let usernameAndPassword = Observable.combineLatest(input.username, input.password) { username, password in
            return (username, password)
        }

//        loginStatus = input.loginTaps.withLatestFrom(usernameAndPassword).flatMapLatest({ pair -> Observable<Result<Moya.Response, MoyaError>> in
//            let (username, password) = pair
//            OpenApi.shared.fetchToken(username, password) { result in
//                return Observable.just(result)
//            }
//        })

//        loginStatus = input.loginTaps.withLatestFrom(usernameAndPassword).flatMapLatest({ pair -> Observable<Response> in
//            let (username, password) = pair
//            return OpenApi.shared.fetchToken_(username, password)
//        })

//        loginStatus = input.loginTaps.withLatestFrom(usernameAndPassword).asSingle().flatMap { pair -> Single<Response> in
//            let (username, password) = pair
//            return OpenApi.shared.fetchToken_(username, password)
//        }

//        loginStatus = input.loginTaps.withLatestFrom(usernameAndPassword).flatMapLatest({ pair -> Single<Response> in
//            let (username, password) = pair
//            return OpenApi.shared.fetchToken_(username, password)
//            })
    }
}
