//
//  AppConfigService.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/21.
//

import Foundation
import Moya

private let BASE_URL = "https://dev.chinamye.com"
private let GET_CONFIG = "/cache/plat/getTabsByGuid/"

enum AppConfigService {
    case fetchConfig(domain: String, bundleId: String, productID: String)
}

extension AppConfigService : AuthorizedTargetType {
    var authType: AuthorizationType {
        return .bearer
    }
    
    var baseURL: URL {
        return URL.init(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .fetchConfig(_, _, let productID):
            return "\(GET_CONFIG)\(productID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchConfig:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .fetchConfig(let domain, let bundleId, let productID):
            return "{\"domain\":\"\(domain)\", \"bundleId\":\"\(bundleId)\", \"productID\":\"\(productID)\"}".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case let .fetchConfig(domain, bundleId, _):
            return .requestParameters(parameters: ["domain": domain, "authKey":bundleId.md5], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
