//
//  UserService.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/11.
//

import Foundation
import RxSwift
import RxCocoa

class UserService {

    static let shared = UserService.init()
    private init() {}

    private lazy var account: Account? = { () -> Account? in
        let dict = UserDao.init().fetchActiveAccount()
        if let userId = dict?[UserID] {
            var acc = Account.init(userId)
            acc.cnname = dict?[CNName]
            acc.headUrl = dict?[HeadUrl]
            acc.password = dict?[Password]
            return acc
        }
        return nil
    }()

    var activeAccount: Account? {
        return self.account
    }

    func save(account: Account) -> Signal<RequestState<Bool>> {
        return Observable.create { observer -> Disposable in
            observer.onNext(.requesting)
            DispatchQueue.serviceQueue.async {
                let userDao = UserDao.init()
                let result = userDao.saveAccount(account.toJson())
                if result {
                    observer.onNext(.success(true))
                } else {
                    observer.onNext(.failure("save account fail!"))
                }
            }
            return Disposables.create()
        }.asSignal(onErrorJustReturn: .failure("save account fail!"))
    }
}
