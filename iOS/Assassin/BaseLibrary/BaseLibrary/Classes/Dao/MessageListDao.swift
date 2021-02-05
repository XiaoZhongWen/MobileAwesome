//
//  MessageListDao.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2021/2/3.
//

import Foundation

public class MessageListDao {

    public init() {}

    public func fetchMessageList() -> [String] {
        let list = MessageListService().fetchMessageList()
        var msgList:[String] = []
        for item in list {
            if let msgTip = MessageTip.deserialize(from: item) {
                if let jsonStr = msgTip.toJSONString() {
                    msgList.append(jsonStr)
                }
            }
        }
        return msgList
    }

    public func fetchLastestConversation(userId: String, pageSize: Int) -> [String] {
        let list = MessageListService().fetchLastConversation(userId: userId, pageSize: pageSize)
        return []
    }

    public func fetchPreviousConversation(userId: String, timestamp: Int, pageSize: Int) -> [String] {
        return []
    }
}
