//
//  UserDao.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/11.
//

import Foundation

/// 用户表访问对象
class UserDao {
    /// 保存用户账号信息
    /// - Parameter account: 用户账号信息
    func saveAccount(_ account: [String:String]?) {
        guard let userID = account?[UserID], let password = account?[Password] else {
            return
        }
        let headUrl = account?[HeadUrl] ?? ""
        let nickname = account?[Nickname] ?? ""

        DBService.shared.inDatabase { (db) in
            do {
                try db.executeUpdate("INSERT INTO TB_ACCOUNT (userID, password, headUrl, nickname, isActive) VALUES (?, ?, ?, ?, ?)", values: [userID, password, headUrl, nickname, true])
            } catch {}
        }
    }

    /// 获取已登录用户账号信息
    /// - Returns: 已登录用户账号信息
    func fetchActiveAccount() -> [String:String]? {
        var account: [String:String]?
        DBService.shared.inDatabase { (db) in
            do {
                let resultSet = try db.executeQuery("SELECT * FROM TB_ACCOUNT WHERE isActive = ?", values: [true])
                account = Dictionary.init()
                while resultSet.next() {
                    if let userID = resultSet.string(forColumn: UserID) {
                        account?[UserID] = userID
                    }

                    if let password = resultSet.string(forColumn: Password) {
                        account?[Password] = password
                    }

                    if let headUrl = resultSet.string(forColumn: HeadUrl) {
                        account?[HeadUrl] = headUrl
                    }

                    if let nickname = resultSet.string(forColumn: Nickname) {
                        account?[Nickname] = nickname
                    }
                }
            } catch {}
        }
        return account
    }
}
