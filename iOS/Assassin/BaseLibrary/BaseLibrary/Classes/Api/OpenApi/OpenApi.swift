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
        let (username, password) = UserDao().fetchAccount()
        let basicAuthCredentials = (username + ":" + password).data(using: .utf8)
        let token = basicAuthCredentials?.base64EncodedString(options: .lineLength76Characters)
        let provider = MoyaProvider<OpenApiService>(
            plugins: [
                AuthPlugin(tokenClosure: { () -> String? in
                    return token
                })
            ]
        )
        provider.request(.fetchToken) { (result) in
            switch result {
            case let .success(response):
                if response.statusCode == 200 {
                    let data = response.data
                    let json = String.init(data: data, encoding: .utf8)
                    print(json)
                } else {
                    let error = MoyaError.stringMapping(response)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
