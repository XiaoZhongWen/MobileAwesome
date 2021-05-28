//
//  AuthPlugin.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/22.
//

import Foundation
import Moya

/// 认证插件
struct AuthPlugin: PluginType {
    let tokenClosure: () -> String?
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let token = tokenClosure(), let target = target as? AuthorizedTargetType else {
            return request
        }
        var request = request
        request.addValue(target.authType.value + " " + token, forHTTPHeaderField: "Authorization")
        return request
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print()
    }
}
