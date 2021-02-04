//
//  ShareService.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2021/2/2.
//

import Foundation
import Moya

private let BASE_URL = "https://share.chinamye.com"
private let FETCH_SHARE_LIST = "/share/getNews"

enum ShareService {
    case fetchShareList(params: [String: Any])
}

extension ShareService: AuthorizedTargetType {
    var authType: AuthorizationType {
        return .bearer
    }

    var baseURL: URL {
        return URL.init(string: BASE_URL)!
    }

    var path: String {
        switch self {
        case .fetchShareList(_):
            return FETCH_SHARE_LIST
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchShareList(_):
            return .post
        }
    }

    var sampleData: Data {
        switch self {
        case .fetchShareList(_):
            return "".utf8Encoded
        }
    }

    var task: Task {
        switch self {
        case let .fetchShareList(params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
