//
//  AppConfig.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/21.
//

import Foundation
import Moya

public class AppConfig {
    // 单例
    public static let shared = AppConfig()
    let provider: MoyaProvider<AppConfigService>
    
    private init() {
        provider = MoyaProvider<AppConfigService>()
    }
    
    /// 获取app配置数据
    /// - Parameter completionHandle: 完成回调
    public func fetchConfig(domain: String,
                     bundleId: String,
                     productID: String,
                     completionHandle: @escaping (_ response: [String:Any]) -> Void) {
        provider.request(.fetchConfig(domain: domain, bundleId: bundleId, productID: productID)) { result in
            print(result)
        }
    }
}
