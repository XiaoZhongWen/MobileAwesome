//
//  Share.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2021/2/3.
//

import Foundation
import Moya

public class Share {
    private init() {}
    public static let shared = Share()

    func fetchShareList(params: [String: Any], completion: @escaping Completion) {
        let provider = MoyaProvider<ShareService>(
            plugins: [
                AuthPlugin.init(tokenClosure: { () -> String? in
                    let json = UserDefaults.init().value(forKey: TOKEN_KEY) as? String
                    let token = Token.deserialize(from: json)
                    return token?.access_token
                })
            ]
        );
        let target = ShareService.fetchShareList(params: params)
        let command = RequestCommand.init(provider, target, completion)
        command.execute()
    }

    public func fetchLatest(pageSize: Int, completion: @escaping Completion) {
        let params = [
            "type": 1,
            "requestCount": pageSize
        ]
        self.fetchShareList(params: params, completion: completion)
    }

    public func fetchMore(pageSize: Int, sessionId: String, completion: @escaping Completion) {
        let params = [
            "type": 1,
            "requestCount": pageSize,
            "maxId": sessionId
        ] as [String : Any]
        self.fetchShareList(params: params, completion: completion)
    }
}
