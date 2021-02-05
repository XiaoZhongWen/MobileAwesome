//
//  ApisService.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2021/1/27.
//

import Foundation
import Moya

private let BASE_URL = "https://apis.chinamye.com"
private let FETCH_CONTACTS_LIST = "/address/listAll"
private let FETCH_USER_INFO = "/users/showOther"

enum ApisService {
    case fetchContactsList
    case fetchUserInfo(userId: String)
}

extension ApisService : AuthorizedTargetType {
    var authType: AuthorizationType {
        return .bearer
    }

    var baseURL: URL {
        return URL.init(string: BASE_URL)!
    }

    var path: String {
        switch self {
        case .fetchContactsList:
            return FETCH_CONTACTS_LIST
        case .fetchUserInfo(_):
            return FETCH_USER_INFO
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchContactsList, .fetchUserInfo(_):
            return .post
        }
    }

    var sampleData: Data {
        switch self {
        case .fetchContactsList, .fetchUserInfo(_):
            return "".utf8Encoded
        }
    }

    var task: Task {
        switch self {
        case .fetchContactsList:
            return .requestPlain
        case let .fetchUserInfo(userId):
            return .requestParameters(parameters:["username":userId], encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
