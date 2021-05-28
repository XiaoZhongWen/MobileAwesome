//
//  OpenApiProvider.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/24.
//

import Moya
import RxSwift
import Result

class OpenApiProvider {
    static let shared = OpenApiProvider.init()
    private init() {}

    func fetchToken(_ username:String, _ password: String, completion: @escaping Completion) {
        let basicAuthCredentials = (username + ":" + password).data(using: .utf8)
        let token = basicAuthCredentials?.base64EncodedString(options: .lineLength76Characters)
        let plugin = AuthorizedPlugin.init(token)
        let provider = MoyaProvider<OpenApi>(plugins: [plugin])
        provider.request(.fetchToken, completion: completion)
    }
}
