//
//  RequestCommand.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/24.
//

import Foundation

import Moya

class RequestCommand<Target: TargetType>: ApiCommand {
    
    let provider: MoyaProvider<Target>
    let target: Target
    let completion: ApiCompletion
    
    init(_ provider:MoyaProvider<Target>, _ target:Target, _ completion: @escaping ApiCompletion) {
        self.provider = provider
        self.target = target
        self.completion = completion
    }
    
    func execute() {
        self.provider.request(self.target) {
            result in
            switch result {
            case let .success(response):
                if response.statusCode == 401 {
                    OpenApi.shared.fetchToken { (result) in
                        switch result {
                        case .success(_):
                            self.execute()
                        case .failure(_):
                            self.completion(.failure(MoyaError.stringMapping(response)))
                        }
                    }
                } else {
                    print(String.init(data: response.data, encoding: .utf8))
                    self.completion(.failure(MoyaError.stringMapping(response)))
                }
            case let .failure(error):
                self.completion(.failure(MoyaError.encodableMapping(error)))
            }
        }
    }
}
