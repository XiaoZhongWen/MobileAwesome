//
//  AuthorizedPlugin.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/24.
//

import Moya
import Result

struct AuthorizedPlugin: PluginType {
    let token: String?

    init(_ token: String?) {
        self.token = token
    }

    static var `default`: AuthorizedPlugin {
        get {
            let json = UserDefaults.init().value(forKey: TOKEN_KEY) as? String
            let token = Token.deserialize(from: json)
            return AuthorizedPlugin.init(token?.access_token)
        }
    }

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let tokenStr = token, let authType = (target as? AuthorizedTargetType)?.authType.value  else {
            return request
        }
        var request = request
        request.addValue(authType + " " + tokenStr, forHTTPHeaderField: "Authorization")
        return request
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print(result)
    }
}
