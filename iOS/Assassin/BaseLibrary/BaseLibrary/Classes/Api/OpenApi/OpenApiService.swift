//
//  OpenApiService.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/22.
//

import Foundation
import Moya

private let BASE_URL = "https://openapi.chinamye.com"
private let TOKEN = "/mauth/oauth2/login"

enum OpenApiService {
    case fetchToken
}

extension OpenApiService : AuthorizedTargetType {
    var authType: AuthorizationType {
        return .basic
    }
    
    var baseURL: URL {
        print(BASE_URL)
        return URL.init(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .fetchToken:
            return TOKEN
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchToken:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .fetchToken:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .fetchToken:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
