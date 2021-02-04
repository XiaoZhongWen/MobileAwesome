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
}
