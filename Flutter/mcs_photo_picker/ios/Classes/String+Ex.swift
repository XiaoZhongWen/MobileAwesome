//
//  String+Ex.swift
//  Runner
//
//  Created by 肖仲文 on 2022/3/25.
//

import Foundation

public extension String {
    static func uuid() -> String? {
        let uidRef = CFUUIDCreate(nil)
        let str = CFUUIDCreateString(nil, uidRef)
        return str as String?
    }
}
