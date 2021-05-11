//
//  UserService.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/11.
//

import Foundation

class UserService {

    static let shared = UserService.init()
    private init() {}

    lazy var account: Account? = { () -> Account? in
        let dict = UserDao.init().fetchActiveAccount()
//        var acc = Account.init(<#T##userId: String##String#>)
        return nil
    }()
}
