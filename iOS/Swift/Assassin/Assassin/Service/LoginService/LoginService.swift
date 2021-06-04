//
//  LoginService.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/22.
//

import RxSwift
import RxCocoa
import Moya

class LoginService: BaseService, LoginApi {
    func signup(_ username: String, _ password: String) -> Single<Bool> {
        let pwd = password.md5
        return Single<Bool>.create { single in
            OpenApiProvider.shared.fetchToken(username + "@" + Domain, pwd) { result in
                switch result {
                case let .success(response):
                    if let jsonStr = try? response.mapString() {
                        let token = Token.deserialize(from: jsonStr)
                        let account = Account.init(username)
                        account.password = pwd
                        account.cnname = token?.cnname
                        account.headUrl = token?.headUrl
                        UserService.shared.save(account: account).emit { result in
                            print(result)
                        }.disposed(by: self.disposeBag)
                    }
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
