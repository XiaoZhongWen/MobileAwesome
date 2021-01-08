//
//  OpenApi+Rx.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2020/12/31.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation
import RxSwift
import BaseLibrary
import Moya

extension OpenApi: ReactiveCompatible {
    func fetchToken(_ username: String, _ password: String) -> Observable<LoginStatusType> {
        return Observable.create { [weak self] observer -> Disposable in
            observer.onNext(LoginStatusType.logining)
            let token = self?.fetchToken(username, password) { result in
                switch result {
                case let .success(response):
                    if response.statusCode == 200 {
                        do {
                            let jsonStr = try response.mapString()
                            let jsonObj = try response.mapJSON() as? NSDictionary
                            let account = NSMutableDictionary.init(dictionary: jsonObj ?? NSDictionary.init())
                            account.setObject(username, forKey: "username" as NSCopying)
                            account.setObject(password, forKey: "password" as NSCopying)
                            let userService = UserService.init()
                            userService.save(basicAuthentication: jsonStr)
                            userService.save(account: account)
                            observer.onNext(.loginSuccess)
                        } catch {
                            observer.onError(MoyaError.jsonMapping(response))
                        }
                    } else {
                        observer.onError(MoyaError.jsonMapping(response))
                    }
                case let .failure(error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                token?.cancel()
            }
        }
    }
}
