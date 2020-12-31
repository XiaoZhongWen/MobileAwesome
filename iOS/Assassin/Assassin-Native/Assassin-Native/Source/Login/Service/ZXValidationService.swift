//
//  ZXValidationService.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2020/12/31.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation
import RxSwift

enum ZXValidationResult {
    case empty
    case validating
    case success(message: String)
    case failure(message: String)
}

extension ZXValidationResult {
    var isValid: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
}

class ZXValidationService {
    func validatePassword(password: String) -> Observable<ZXValidationResult> {
        let isValid = password.count > 6
        if isValid {
            return .just(.success(message: "the length of password > 6"))
        } else {
            return .just(.failure(message: "the length of password <= 6"))
        }
    }
}
