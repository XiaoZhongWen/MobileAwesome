//
//  LoginService.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/22.
//

import RxSwift
import RxCocoa

class LoginService: LoginApi {
    func signup(_ username: String, _ password: String) -> Driver<Bool> {
        return Observable.create { (observer) -> Disposable in
            observer.onNext(true)
            return Disposables.create()
        } .asDriver(onErrorJustReturn: true)
    }
}
