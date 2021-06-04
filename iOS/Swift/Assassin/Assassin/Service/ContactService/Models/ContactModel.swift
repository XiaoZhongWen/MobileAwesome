//
//  ContactModel.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/6/4.
//

import HandyJSON

class ContactModel: HandyJSON {
    var username: String?
    var nickname: String?
    var headUrl: String?
    var depts: String?

    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.username <-- "userName"
        mapper <<<
            self.nickname <-- "cnname"
    }

    required init() {}
}
