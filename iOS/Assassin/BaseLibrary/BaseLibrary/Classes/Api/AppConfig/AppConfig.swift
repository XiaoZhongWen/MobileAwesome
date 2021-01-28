//
//  AppConfig.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/21.
//

import Foundation
import Moya
import RxSwift

public class AppConfig {
    // 单例
    public static let shared = AppConfig()
    
    private init() {
    }
    
    /// 获取app配置数据
    /// - Parameter completionHandle: 完成回调
    public func fetchConfig(domain: String,
                     bundleId: String,
                     productId: String,
                     completion: @escaping Completion) {
        
        if domain.count == 0 || bundleId.count == 0 || productId.count == 0 {
            completion(.failure(MoyaError.requestMapping("parameters are invalid")))
            return
        }
        
        let provider = MoyaProvider<AppConfigService>(
            plugins: [
                AuthPlugin.init(tokenClosure: { () -> String? in
                    let json = UserDefaults.init().value(forKey: TOKEN_KEY) as? String
                    let token = Token.deserialize(from: json)
                    return token?.access_token
                })
            ]
        )
        let target = AppConfigService.fetchConfig(domain: domain, bundleId: bundleId, productID: productId)
        let command = RequestCommand.init(provider, target, completion)
        command.execute()
    }
}
