//
//  OpenApi.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/22.
//

import Foundation
import Moya

public class OpenApi {
    public static let shared = OpenApi()
    
    private init() {}
    
    public func fetchToken(completionHandle: @escaping (_ response: [String: Any]) -> Void) {
        let username = "13545118725@cike.com"
        let password = "zhongwen912".md5
        let basicAuthCredentials = (username + ":" + password).data(using: .utf8)
        let token = basicAuthCredentials?.base64EncodedString(options: .lineLength64Characters)
        let provider = MoyaProvider<OpenApiService>(
            plugins: [
                AuthPlugin(tokenClosure: { () -> String? in
                    return token
                })
            ]
        )
        provider.request(.fetchToken) { (result) in
            print(result)
        }
    }
}
