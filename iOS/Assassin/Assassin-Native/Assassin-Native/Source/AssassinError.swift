//
//  AssassinError.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/9.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import Foundation

enum AssassinError: Error {
    case urlInvalidError
}

extension AssassinError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .urlInvalidError:
            return "The url is invalid."
        }
    }
    
}
