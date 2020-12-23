//
//  UserDao.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/22.
//

import Foundation

class UserDao {
    func fetchAccount() -> (username: String, password: String) {
        return ("13545118725@cike.com", "zhongwen912".md5)
    }
}
