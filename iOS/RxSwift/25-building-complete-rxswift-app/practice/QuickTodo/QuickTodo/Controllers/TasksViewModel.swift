//
//  TasksViewModel.swift
//  QuickTodo
//
//  Created by 肖仲文 on 2021/10/15.
//

import Foundation

struct TasksViewModel {
    let taskService: TaskServiceType
    let sceneCoordinator: SceneCoordinator

    init(taskService: TaskServiceType, sceneCoordinator: SceneCoordinator) {
        self.taskService = taskService
        self.sceneCoordinator = sceneCoordinator
    }
}
