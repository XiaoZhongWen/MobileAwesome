//
//  LoginService.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/22.
//

import RxSwift
import RxCocoa
import Moya

class LoginService: LoginApi {
    func signup(_ username: String, _ password: String) -> Single<Bool> {
        return Single<Bool>.create { single in
            OpenApiProvider.shared.fetchToken(username + "@" + Domain, password) { result in
                switch result {
                case let .success(response):
                    single(.success(response.statusCode == 200))
                    break
                case let .failure(error):
                    single(.error(error))
                    break
                }
            }
            return Disposables.create()
        }
    }
}
