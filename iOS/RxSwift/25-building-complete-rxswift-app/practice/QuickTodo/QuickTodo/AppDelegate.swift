//
//  AppDelegate.swift
//  QuickTodo
//
//  Created by 肖仲文 on 2021/10/14.
//

import UIKit
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        let sceneCoordinator = SceneCoordinator.init(window: self.window!)
        let taskService = TaskService.init()
        let tasksViewModel = TasksViewModel.init(taskService: taskService, sceneCoordinator: sceneCoordinator)
        let scene = Scene.tasks(tasksViewModel)
        sceneCoordinator.transition(to: scene, type: .root)
        self.window?.makeKeyAndVisible()

        return true
    }
}

