//
//  AuthorizedTargetType.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/22.
//

import Foundation
import Moya

protocol AuthorizedTargetType : TargetType {
    var authType:AuthorizationType {get}
}
