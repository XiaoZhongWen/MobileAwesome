//
//  ApplicationService.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/12.
//

import Foundation
import HandyJSON

class ApplicationService {
    static let shared = ApplicationService.init()
    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/\(PlistFileNameOfConfiguration)")
    private init() {}

    lazy private var applicationConfiguration: ApplicationConfiguration? = { () -> ApplicationConfiguration? in
        let plist = NSDictionary.init(contentsOfFile: path)
        let json = plist?.object(forKey: KeyOfConfiguration) as? [String: Any]
        return ApplicationConfiguration.deserialize(from: json)
    }()

    /// 获取应用配置
    var currentAppConfiguration: ApplicationConfiguration? {
        return self.applicationConfiguration
    }

    /// 保存最新应用配置
    /// - Parameter json: 应用配置json对象
    func save(ApplicationConfiguration json:[String: Any]) {
        DispatchQueue.serviceQueue.async {
            let plist = NSMutableDictionary.init(contentsOfFile: self.path)
            plist?.setObject(json, forKey: KeyOfConfiguration as NSCopying)
            plist?.write(toFile: self.path, atomically: true)
        }
    }
}
