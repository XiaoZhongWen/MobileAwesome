//
//  DefaultConfiguration.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/8.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import Foundation
import HandyJSON

class DefaultConfiguration {
    static let shared = DefaultConfiguration()
    
    private var plist: NSMutableDictionary?
    
    private var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] +
        "/DefaultConfiguration.plist"
    
    var applicationConfiguration: [String: Any]? {
        let json = plist?.object(forKey: Global_ApplicationConfiguration_Key) as? [String: Any]
        return json
    }
    
    private init() {
        if !FileManager.default.fileExists(atPath: path) {
            if let from = Bundle.main.path(forResource: "DefaultConfiguration", ofType: "plist") {
                try? FileManager.default.copyItem(atPath: from, toPath: path)
            }
        }
        plist = NSMutableDictionary.init(contentsOfFile: path)
        let appConfiguration = plist?.object(forKey: Global_ApplicationConfiguration_Key)
        if appConfiguration == nil {
            if let jsonPath = Bundle.main.path(forResource: "default_app_config", ofType: "json") {
                do {
                    let jsonStr = try String.init(contentsOfFile: jsonPath)
                    if let json = ApplicationConfiguration.deserialize(from: jsonStr)?.toJSON() {
                        plist?.setObject(json, forKey: Global_ApplicationConfiguration_Key as NSCopying)
                        plist?.write(toFile: path, atomically: true)
                    }
                } catch {}
            }
        }
    }
    
    func update(applicationConfiguration: [String: Any]) {
        plist?.setObject(applicationConfiguration, forKey: Global_ApplicationConfiguration_Key as NSCopying)
        plist?.write(toFile: path, atomically: true)
    }
}
