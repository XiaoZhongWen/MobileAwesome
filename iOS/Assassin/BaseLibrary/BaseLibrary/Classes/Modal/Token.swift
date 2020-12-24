//
//  Token.swift
//  Alamofire
//
//  Created by 肖仲文 on 2020/12/24.
//

import HandyJSON

struct Token: HandyJSON {
    var access_token: String?
    var token_type: String?
    var refresh_token: String?
    var expires_in: Int?
    var scope: [String]?
    var username: String?
    var cnname: String?
    var headUrl: String?
}
