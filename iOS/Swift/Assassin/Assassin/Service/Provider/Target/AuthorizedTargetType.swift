//
//  AuthorizedTargetType.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/24.
//

import Moya

protocol AuthorizedTargetType: TargetType {
    var authType:AuthorizationType {get}
}
