//
//  Account.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/11.
//

import Foundation

class Account {
    private var userId: String

    init(_ userId: String) {
        self.userId = userId
    }

    var username: String? {
        return userId
    }
    var password: String?
    var cnname: String?
    var headUrl: String?

    func toJson() -> [String:String] {
        return ["userId"    :userId,
                "password"  :password ?? "",
                "cnname"    : cnname ?? "",
                "headUrl"   :headUrl ?? ""]
    }
}
