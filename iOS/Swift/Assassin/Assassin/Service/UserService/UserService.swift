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

    private lazy var account: Account? = { () -> Account? in
        let dict = UserDao.init().fetchActiveAccount()
        if let userId = dict?[UserID] {
            var acc = Account.init(userId)
            acc.cnname = dict?[Nickname]
            acc.headUrl = dict?[HeadUrl]
            acc.password = dict?[Password]
            return acc
        }
        return nil
    }()

    var activeAccount: Account? {
        return self.account
    }

}
