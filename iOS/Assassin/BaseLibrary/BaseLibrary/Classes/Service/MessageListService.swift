//
//  MessageListService.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2021/2/3.
//

import Foundation

class MessageListService {
    func fetchMessageList() -> [[String:Any]] {
        var messageList: [[String:Any]] = []
        DaoService.shared.inDatabase { db in
            do {
                let resultSet = try db.executeQuery("SELECT * FROM TB_MESSAGE", values: nil)
                while resultSet.next() {
                    var msg: [String: Any] = Dictionary()
                    msg["isUnread"] = resultSet.bool(forColumn: "unSee")
                    msg["senderId"] = resultSet.string(forColumn: "otherAccounts")
                    msg["senderId_g"] = resultSet.string(forColumn: "phone")
                    msg["receiverId"] = resultSet.string(forColumn: "localAccount")
                    msg["messageType"] = resultSet.string(forColumn: "lastMessageID")
                    msg["receiveTimestamp"] = resultSet.long(forColumn: "time")
                    msg["messageContent"] = resultSet.string(forColumn: "content")
                    msg["groupName"] = resultSet.string(forColumn: "groupName")
                    messageList.append(msg)
                }
            } catch {
                print(db.lastError())
            }
        }
        return messageList
    }
}
