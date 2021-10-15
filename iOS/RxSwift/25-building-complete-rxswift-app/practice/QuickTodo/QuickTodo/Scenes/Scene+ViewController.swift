//
//  Scene+ViewController.swift
//  QuickTodo
//
//  Created by 肖仲文 on 2021/10/15.
//

import UIKit

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        case .tasks(let viewModel):
            let taskVc = TasksViewController.init()
            taskVc.bindViewModel(to: viewModel)
            return taskVc
        case .editTask(let viewModel):
            let editTaskVc = EditTaskViewController.init()
            editTaskVc.bindViewModel(to: viewModel)
            return editTaskVc
        }
    }
}
