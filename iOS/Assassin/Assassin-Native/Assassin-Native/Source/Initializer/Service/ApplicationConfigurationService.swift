//
//  ApplicationConfigurationService.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/8.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import Foundation

class ApplicationConfigurationService {
    static let shared = ApplicationConfigurationService.init()
    
    private var appConfiguration: ApplicationConfiguration?
    
    private init() {
        let json = DefaultConfiguration.shared.applicationConfiguration
        appConfiguration = ApplicationConfiguration.deserialize(from: json)
    }

    func checkAndUpdate(configuration: [String: Any]?) {
        let newConfiguration = ApplicationConfiguration.deserialize(from: configuration)
        guard let newVersion = newConfiguration?.version, let version = appConfiguration?.version else {
            return
        }
        if version != newVersion {
            if let json = newConfiguration?.toJSON() {
                DefaultConfiguration.shared.update(applicationConfiguration: json)
            }
        }
    }
    
    func fetchAppTabs() -> [Tab]? {
        return appConfiguration?.tabs
    }
}
