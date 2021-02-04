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
}
