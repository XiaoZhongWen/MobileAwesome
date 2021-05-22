//
//  LoginValidateService.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/22.
//

import Foundation

class LoginValidateService: ValidationService {
    func validateUsername(_ username: String) -> ValidationResult {
        return .empty
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        return .empty
    }
}
