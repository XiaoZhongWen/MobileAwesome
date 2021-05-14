//
//  DispatchQueue+Assassin.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/12.
//

import Foundation

extension DispatchQueue {
    static var serviceQueue: DispatchQueue {
        var autoreleaseFrequency: AutoreleaseFrequency = .inherit
        if #available(iOS 10.0, *) {
            autoreleaseFrequency = .workItem
        }
        return DispatchQueue.init(label: ServiceDispatchQueue, qos: DispatchQoS.utility, attributes: [], autoreleaseFrequency: autoreleaseFrequency, target: nil)
    }
}
