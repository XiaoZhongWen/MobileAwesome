//
//  ContactDao.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/6/4.
//

import Foundation

class ContactDao {
    func fetchContacts(offset: Int, limit: Int) -> [[String:Any]] {
        var contacts:[[String:Any]] = []
        DBService.shared.inDatabase { db in
            if let set = try? db.executeQuery("SELECT * FROM TB_FRIEND_LIST limit ? offset ?", values: [limit, offset]) {
                var contact:[String:Any] = Dictionary.init()
                while set.next() {
                    let username = set.string(forColumn: "userName")
                    let nickname = set.string(forColumn: "cnname")
                    let headUrl = set.string(forColumn: "headUrl")
                    let depts = set.string(forColumn: "depts")
                    contact[UserName] = username
                    contact[CNName] = nickname
                    contact[HeadUrl] = headUrl
                    contact[Depts] = depts
                    contacts.append(contact)
                }
            }
        }
        return contacts
    }
}
