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
        let mgr = FileManager.default
        let mainBundlePath = Bundle.main.bundlePath
        if !mgr.fileExists(atPath: path) {
            let bPath = mainBundlePath.appending("/DefaultConfiguration.plist")
            try? mgr.copyItem(atPath: bPath, toPath: path)
        }
        var plist:NSMutableDictionary? = NSMutableDictionary.init(contentsOfFile: path)
        if let json = plist?.object(forKey: KeyOfConfiguration) as? String {
            return ApplicationConfiguration.deserialize(from: json)
        } else {
            let jsonPath = mainBundlePath.appending("/default_app_config.json")
            do {
                let json = try String.init(contentsOfFile: jsonPath)
                plist?.setObject(json, forKey: KeyOfConfiguration as NSCopying)
                return ApplicationConfiguration.deserialize(from: json)
            } catch {}
            return nil
        }
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
