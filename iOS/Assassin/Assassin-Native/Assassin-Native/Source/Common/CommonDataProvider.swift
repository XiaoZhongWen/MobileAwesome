//
//  CommonDataProvider.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/25.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import Foundation

@objc(CommonDataProvider)
class CommonDataProvider: NSObject {
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc
    func constantsToExport() -> [String: Any]! {
        return ["themeColor": Global_Theme_Color]
    }
}
