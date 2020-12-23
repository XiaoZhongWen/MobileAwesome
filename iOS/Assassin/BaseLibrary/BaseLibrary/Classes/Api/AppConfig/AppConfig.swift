//
//  AppConfig.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/21.
//

import Foundation
import Moya
import RxSwift

public class AppConfig {
    // 单例
    public static let shared = AppConfig()
    
    private init() {
    }
    
    /// 获取app配置数据
    /// - Parameter completionHandle: 完成回调
    public func fetchConfig(domain: String,
                     bundleId: String,
                     productID: String,
                     completionHandle: @escaping (_ response: [String:Any]) -> Void) {
        let disposeBag = DisposeBag()
        let sequenceThatErrors = Observable<Result<Moya.Response, MoyaError>>.create { (observer) -> Disposable in
            let provider = MoyaProvider<AppConfigService>(
                plugins: [
                    AuthPlugin.init(tokenClosure: { () -> String? in
                        return ""
                    })
                ]
            )
            provider.request(.fetchConfig(domain: domain, bundleId: bundleId, productID: productID)) { result in
                switch result {
                case let .success(response):
                    if response.statusCode == 401 {
                        OpenApi.shared.fetchToken { (result) in
                            
                        }
                        observer.onError(ApiError.oAuthFailure)
                    } else {
                        observer.onNext(result)
                    }
                case .failure(_):
                    observer.onNext(result)
                }
            }
            return Disposables.create()
        }
        
        sequenceThatErrors.retry().subscribe { (result) in
            
        }.disposed(by: disposeBag)
    }
}
