//
//  Api.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/23.
//

import Moya

public let TOKEN_KEY = "TOKEN"

public enum ApiResult<Success, Failure> {
    case success(Success)
    case failure(Failure)
}

public typealias ApiCompletion = (_ result: ApiResult<Data, MoyaError>) -> Void
