//
//  SceneCoordinatorType.swift
//  QuickTodo
//
//  Created by 肖仲文 on 2021/10/15.
//

import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene:Scene, type:SceneTransitionType) -> Completable;

    @discardableResult
    func pop(animated:Bool) -> Completable;
}

extension SceneCoordinatorType {
    func pop() -> Completable {
        return pop(animated: true)
    }
}
