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

extension OpenApi: ReactiveCompatible {
    func fetchToken(_ username: String, _ password: String) -> Single<Bool> {
        return Single.create { single -> Disposable in
            self.fetchToken(username, password) { result in
                switch result {
                case .success:
                    return single(.success(true))
                case let .failure(error):
                    return single(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
