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

    func fetchLastConversation(userId: String, pageSize: Int) -> [[String:Any]] {
        var list: [[String:Any]] = []
        DaoService.shared.inDatabase { db in
            do {
                let resultSet = try db.executeQuery("SELECT * FROM TB_CHAT WHERE localParty='13545118725' AND remoteParty='\(userId)\' ORDER BY 'offlineDate' DESC LIMIT '\(pageSize)\'", values: nil)
                while resultSet.next() {
                    var conversation: [String: Any] = Dictionary()
                    let timestamp = resultSet.long(forColumn: "offlineDate")
                    let content = resultSet.string(forColumn: "content")
                    let contentType = resultSet.string(forColumn: "contentType")
                    let messageUUID = resultSet.string(forColumn: "messageUUID")
                    let bulkPhone = resultSet.string(forColumn: "bulkPhone")
                    let incoming = resultSet.bool(forColumn: "isComing")
                    conversation["timestamp"] = timestamp;
                    conversation["content"] = content;
                    conversation["contentType"] = contentType;
                    conversation["messageUUID"] = messageUUID;
                    conversation["bulkPhone"] = bulkPhone;
                    conversation["incoming"] = incoming;
                    list.append(conversation)
                }
            } catch {
                print(db.lastError())
            }
        }
        return list
    }

    func fetchPreviousConversation(userId: String, timestamp: Int, pageSize: Int) -> [[String:Any]] {
        var list: [[String:Any]] = []
        DaoService.shared.inDatabase { db in
            do {
                let resultSet = try db.executeQuery("SELECT * FROM TB_CHAT WHERE localParty='13545118725' AND remoteParty='\(userId)\' AND offlineDate <= '?' ORDER BY 'offlineDate' DESC LIMIT '\(pageSize)\'", values: nil)
                while resultSet.next() {
                    var conversation: [String: Any] = Dictionary()
                    let timestamp = resultSet.long(forColumn: "offlineDate")
                    let content = resultSet.string(forColumn: "content")
                    let contentType = resultSet.string(forColumn: "contentType")
                    let messageUUID = resultSet.string(forColumn: "messageUUID")
                    let bulkPhone = resultSet.string(forColumn: "bulkPhone")
                    let incoming = resultSet.bool(forColumn: "isComing")
                    conversation["timestamp"] = timestamp;
                    conversation["content"] = content;
                    conversation["contentType"] = contentType;
                    conversation["messageUUID"] = messageUUID;
                    conversation["bulkPhone"] = bulkPhone;
                    conversation["incoming"] = incoming;
                    list.append(conversation)
                }
            } catch {
                print(db.lastError())
            }
        }
        return list
    }
}
