//
//  State.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/6/4.
//

import Foundation

enum RequestState<T> {
    case requesting
    case success(T?)
    case failure(Any?)
}
