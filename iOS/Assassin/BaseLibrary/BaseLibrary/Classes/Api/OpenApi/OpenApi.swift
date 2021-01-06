//
//  OpenApi.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/22.
//

import Foundation
import Moya
import RxSwift

public class OpenApi {
    public static let shared = OpenApi()
    
    private init() {}

    public func fetchToken(_ username: String, _ password: String, _ completion: @escaping Completion) -> Cancellable {
        let basicAuthCredentials = (username + ":" + password).data(using: .utf8)
        let token = basicAuthCredentials?.base64EncodedString(options: .lineLength76Characters)
        let provider = MoyaProvider<OpenApiService>(
            plugins: [
                AuthPlugin(tokenClosure: { () -> String? in
                    return token
                })
            ]
        )
        let cancellableToken = provider.request(.fetchToken, completion: completion)
        return cancellableToken
    }
}
