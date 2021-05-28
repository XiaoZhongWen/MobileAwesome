//
//  Protocols.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/22.
//

import RxSwift
import RxCocoa

enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}

protocol ValidationService {
    func validateUsername(_ username: String) -> ValidationResult
    func validatePassword(_ password: String) -> ValidationResult
}

protocol LoginApi {
    func signup(_ username: String, _ password: String) -> Single<Bool>
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}
