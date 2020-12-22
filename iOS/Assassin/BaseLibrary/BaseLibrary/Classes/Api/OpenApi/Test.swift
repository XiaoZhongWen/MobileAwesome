//
//  Test.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/22.
//

import Foundation
import Moya

public class Test {
    public init(){}
    public func test() {
        let gitHubProvider = MoyaProvider<GitHub>()
        
        gitHubProvider.request(.userProfile("ashfurrow")) {
            result in
            switch result {
            case let .success(response):
                let data = response.data
                let statusCode = response.statusCode
                print(statusCode)
                print(String.init(data: data, encoding: .utf8))
            case let .failure(error):
                print(error)
            }
        }
        
        
//        gitHubProvider
//        provider.request(.zen) { result in
//            // do something with the result (read on for more details)
//            switch result {
//            case let .success(response):
//                let data = response.data
//                let statusCode = response.statusCode
//                print(data)
//                print(data)
//            case let .failure(error):
//                print(error)
//            }
//        }
    }
}
