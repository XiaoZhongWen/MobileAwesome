//
//  BaseProvider.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/24.
//

import Moya

class BaseProvider<Target: TargetType> {
    let provider:MoyaProvider<Target>

    init(_ plugin: PluginType = AuthorizedPlugin.default) {
        provider = MoyaProvider.init(plugins:[plugin])
    }

    
}
