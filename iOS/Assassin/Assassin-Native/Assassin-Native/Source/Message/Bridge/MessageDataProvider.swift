//
//  MessageDataProvider.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/2/4.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import Foundation
import BaseLibrary

@objc(MessageDataProvider)
class MessageDataProvider: NSObject {
    @objc(fetchMessageList:rejecter:)
    func fetchMessageList(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        let list = MessageListDao.init().fetchMessageList()
        resolver(list)
    }

    @objc(fetchLastestConversation:resolve:rejecter:)
    func fetchLastestConversation(userId: String,
                                  resolver: @escaping RCTPromiseResolveBlock,
                                  rejecter: @escaping RCTPromiseRejectBlock) {
        let list = MessageListDao.init().fetchLastestConversation(userId: userId,
                                                                  pageSize: Global_Conversation_Page_Size)
        resolver(list)
    }

    @objc(fetchPreviousConversation:timestamp:resolve:rejecter:)
    func fetchPreviousConversation(userId: String,
                                   timestamp: Int,
                                   resolver: @escaping RCTPromiseResolveBlock,
                                   rejecter: @escaping RCTPromiseRejectBlock) {
        let list = MessageListDao.init().fetchPreviousConversation(userId: userId,
                                                                   timestamp: timestamp,
                                                                   pageSize: Global_Conversation_Page_Size)
        resolver(list)
    }
}
