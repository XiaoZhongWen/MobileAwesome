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
    let completion: Completion
    
    init(_ provider:MoyaProvider<Target>, _ target:Target, _ completion: @escaping Completion) {
        self.provider = provider
        self.target = target
        self.completion = completion
    }
    
    func execute() {
        let userService = UserService.init()
        let account = userService.activeAccount()
        guard let username = account?.username, let password = account?.password else {
            return
        }
        self.provider.request(self.target) {
            result in
            switch result {
            case let .success(response):
                if response.statusCode == 401 {
                    let _ = OpenApi.shared.fetchToken(username, password) { (result) in
                        switch result {
                        case let .success(response):
                            if let jsonStr = try? response.mapString() {
                                userService.save(authentication: jsonStr)
                                self.execute()
                            } else {
                                self.completion(.failure(MoyaError.stringMapping(response)))
                            }
                        case .failure(_):
                            self.completion(.failure(MoyaError.stringMapping(response)))
                        }
                    }
                } else {
                    self.completion(.success(response))
                }
            case let .failure(error):
                self.completion(.failure(error))
            }
        }
    }
}
