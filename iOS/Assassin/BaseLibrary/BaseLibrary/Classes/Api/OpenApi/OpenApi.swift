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
    
    public func fetchToken(_ completion: @escaping Completion) {
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
                    do {
                        let res = try response.mapString() as String
                        print(res)
                    } catch {}
                    let data = response.data
                    let json = String.init(data: data, encoding: .utf8)
                    UserDefaults.init().set(json, forKey: TOKEN_KEY)
                    completion(.success(response))
                } else {
                    completion(.failure(MoyaError.statusCode(response)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
