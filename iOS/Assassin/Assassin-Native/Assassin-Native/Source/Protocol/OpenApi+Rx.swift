//
//  OpenApi+Rx.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2020/12/31.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation
import RxSwift
import BaseLibrary
import Moya

extension OpenApi: ReactiveCompatible {
//    func fetchToken(_ username: String, _ password: String) -> Single<Bool> {
//        return Single.create { [weak self] single -> Disposable in
//            let token = self?.fetchToken(username, password) { result in
//                switch result {
//                case .success:
//                    single(.success(true))
//                case let .failure(error):
//                    single(.error(error))
//                }
//            }
//            return Disposables.create {
//                token?.cancel()
//            }
//        }
//    }
//
//    func fetchToken2(_ username: String, _ password: String) -> Single<Response> {
//        return self.fetchToken1(username, password)
//    }
}
