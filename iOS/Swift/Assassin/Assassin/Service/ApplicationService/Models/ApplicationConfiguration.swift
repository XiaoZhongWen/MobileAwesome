//
//  ApplicationConfiguration.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/12.
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

class ApplicationConfiguration:HandyJSON {
    private var useable: Bool?
    private var version: Int?
    private var proxy: String?
    private var sandbox: Bool?
    private var https: Bool?
    private var iosRnUrl: String?
    private var androidRnUrl: String?
    private var h5Url: String?
    private var registerUrl: String?
    private var changePwdUrl: String?
    private var resetPwdUrl: String?
    private var orgUrl: String?
    private var orgSelectUrl: String?
    private var tabs: [Tab]?

    var currentTabs: [Tab]? {
        return self.tabs
    }

    required init() {}
}
