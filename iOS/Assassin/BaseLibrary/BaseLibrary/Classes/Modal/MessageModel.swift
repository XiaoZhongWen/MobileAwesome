//
//  MessageModel.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2021/2/7.
//

import Foundation
import HandyJSON

public class MessageModel: HandyJSON {
    public var timestamp: Int?
    public var content: String?
    public var contentType: String?
    public var messageUUID: String?
    public var bulkPhone: String?
    public var incoming: Bool?
    required public init() {}
}
