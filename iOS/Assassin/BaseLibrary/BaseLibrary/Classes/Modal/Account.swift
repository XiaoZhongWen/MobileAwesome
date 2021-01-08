//
//  Account.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2021/1/8.
//

import HandyJSON

public class Account: HandyJSON {
    public var username: String?
    public var password: String?
    public var cnname: String?
    public var headUrl: String?

    required public init() {}
}
