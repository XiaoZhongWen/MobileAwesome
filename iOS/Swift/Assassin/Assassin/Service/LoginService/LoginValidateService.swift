//
//  LoginValidateService.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/22.
//

import Foundation

class LoginValidateService: ValidationService {
    func validateUsername(_ username: String) -> ValidationResult {
        if username.count >= 6 {
            return .ok(message: "enable")
        } else if username.count < 6 {
            return .failed(message: "disable")
        }
        return .empty
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        if password.count >= 6 {
            return .ok(message: "enable")
        } else if password.count < 6 {
            return .failed(message: "disable")
        }
        return .empty
    }
}
