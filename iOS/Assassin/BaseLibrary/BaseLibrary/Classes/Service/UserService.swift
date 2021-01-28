//
//  UserService.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2021/1/7.
//

import Foundation
import FMDB

public class UserService {

    public init() {}

    public func save(authentication: String) {
        UserDefaults.init().set(authentication, forKey: TOKEN_KEY)
    }

    public func save(account: NSDictionary) {
        let acc = Account.deserialize(from: account)
        guard let username = acc?.username, let password = acc?.password else {
            print("username or password is empty!")
            return
        }
        DaoService.shared.inDatabase({ db in
            do {
                try db.executeUpdate("INSERT INTO TB_ACCOUNT (userID, password, headUrl, nickname, isActive) VALUES (?, ?, ?, ?, ?)", values: [username, password, acc?.headUrl ?? "", acc?.cnname ?? "", true])
            } catch {
                print(db.lastError())
            }
        })
    }

    public func activeAccount() -> Account? {
        var account: Account?
        
        DaoService.shared.inDatabase({ db in
            do {
                let resultSet = try db.executeQuery("SELECT * FROM TB_ACCOUNT WHERE isActive = ?", values: [true])
                if resultSet.next() {
                    let userID = resultSet.string(forColumn: "userID")
                    let password = resultSet.string(forColumn: "password")
                    let headUrl = resultSet.string(forColumn: "headUrl")
                    let nickname = resultSet.string(forColumn: "nickname")
                    account = Account.init()
                    account?.username = userID
                    account?.password = password
                    account?.headUrl = headUrl
                    account?.cnname = nickname
                }
            } catch {}
        })
        return account
    }
}
