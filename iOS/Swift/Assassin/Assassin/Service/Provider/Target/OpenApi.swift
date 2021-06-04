//
//  OpenApi.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/24.
//

import Moya

private let BASE_URL = "https://openapi.chinamye.com"
private let TOKEN = "/mauth/oauth2/login"

enum OpenApi {
    case fetchToken
}

extension OpenApi: AuthorizedTargetType {
    var authType: AuthorizationType {
        .basic
    }

    var baseURL: URL {
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
