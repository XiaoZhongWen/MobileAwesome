//
//  ApplicationConfiguration.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/8.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import HandyJSON

class Tab: HandyJSON {
    var type: Int?
    var name: String?
    var selIcon: String?
    var unselIcon: String?
    var param: String?
    var rnAccess: String?
    var showMessageNotify: Int?

    required init() {}
}

class ApplicationConfiguration: HandyJSON {
    var useable: Bool?
    var version: Int?
    var proxy: String?
    var sandbox: Bool?
    var https: Bool?
    var iosRnUrl: String?
    var androidRnUrl: String?
    var h5Url: String?
    var registerUrl: String?
    var changePwdUrl: String?
    var resetPwdUrl: String?
    var orgUrl: String?
    var orgSelectUrl: String?
    var tabs: [Tab]?

    required init() {}
}
