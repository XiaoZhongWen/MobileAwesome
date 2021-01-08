//
//  DefaultConfiguration.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/8.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import Foundation

class DefaultConfiguration {
    static let shared = DefaultConfiguration()
    private init() {
        let documentDirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = documentDirPath + "/DefaultConfiguration.plist"
        if !FileManager.default.fileExists(atPath: path) {
            if let from = Bundle.main.path(forResource: "DefaultConfiguration", ofType: "plist") {
                try? FileManager.default.copyItem(atPath: from, toPath: path)
            }
        }
        let plist = NSDictionary.init(contentsOfFile: path)
        let appConfiguration = plist?.object(forKey: Global_ApplicationConfiguration_Key)
        if appConfiguration == nil {
            if let jsonPath = Bundle.main.path(forResource: "app_config", ofType: "json") {
                let json = NSDictionary.init(object: jsonPath, forKey: Global_ApplicationConfiguration_Key as NSCopying)
                json.write(toFile: path, atomically: true)
            }
        }
    }
}
