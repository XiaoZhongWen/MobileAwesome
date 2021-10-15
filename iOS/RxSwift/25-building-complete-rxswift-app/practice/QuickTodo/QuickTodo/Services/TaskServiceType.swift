//
//  TaskServiceType.swift
//  QuickTodo
//
//  Created by 肖仲文 on 2021/10/15.
//

import RxSwift
import RealmSwift

enum TaskServiceError: Error {
    case creationFailed
    case updateFailed(TaskItem)
    case deletionFailed(TaskItem)
    case toggleFailed(TaskItem)
}

protocol TaskServiceType {
    @discardableResult
    func createTask(title: String) -> Observable<TaskItem>

    @discardableResult
    func delete(task: TaskItem) -> Observable<Void>

    @discardableResult
    func update(task: TaskItem, title: String) -> Observable<TaskItem>

    @discardableResult
    func toggle(task: TaskItem) -> Observable<TaskItem>

    func tasks() -> Observable<Results<TaskItem>>
}
