//
//  MessageTip.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2021/2/3.
//

import Foundation
import HandyJSON

public class MessageTip: HandyJSON {
    public var isUnread: Bool?
    public var senderId: String?
    public var senderId_g: String?
    public var receiverId: String?
    public var messageType: String?
    public var receiveTimestamp: Int?
    public var messageContent: String?
    public var groupName: String?

    required public init() {}
}
