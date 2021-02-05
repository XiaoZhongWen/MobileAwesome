//
//  Apis.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2021/1/27.
//

import Foundation
import Moya
import RxSwift

public class Apis {
    private init() {}
    public static let shared = Apis()

    public func fetchContactsList(completion: @escaping Completion) {
        let provider = MoyaProvider<ApisService>(
            plugins: [
                AuthPlugin.init(tokenClosure: { () -> String? in
                    let json = UserDefaults.init().value(forKey: TOKEN_KEY) as? String
                    let token = Token.deserialize(from: json)
                    return token?.access_token
                })
            ]
        );
        let target = ApisService.fetchContactsList
        let command = RequestCommand.init(provider, target, completion)
        command.execute()
    }

    public func fetchUserInfo(userId: String, completion: @escaping Completion) {
        let provider = MoyaProvider<ApisService>(
            plugins: [
                AuthPlugin.init(tokenClosure: { () -> String? in
                    let json = UserDefaults.init().value(forKey: TOKEN_KEY) as? String
                    let token = Token.deserialize(from: json)
                    return token?.access_token
                })
            ]
        );
        let target = ApisService.fetchUserInfo(userId: userId)
        let command = RequestCommand.init(provider, target, completion)
        command.execute()
    }
}
