//
//  SceneCoordinator.swift
//  QuickTodo
//
//  Created by 肖仲文 on 2021/10/15.
//

import RxSwift

class SceneCoordinator: SceneCoordinatorType {
    private let window:UIWindow
    private var currentViewController:UIViewController?

    required init(window:UIWindow) {
        self.window = window
        currentViewController = window.rootViewController
    }

    static func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let viewController = viewController as? UINavigationController {
            return viewController.viewControllers.first!
        } else {
            return viewController
        }
    }

    func pop(animated: Bool) -> Completable {
        let subject = PublishSubject<Void>.init()
        if let presenter = currentViewController?.presentingViewController {
            currentViewController?.dismiss(animated: true, completion: {
                self.currentViewController = SceneCoordinator.actualViewController(for: presenter)
                subject.onCompleted()
            })
        } else if let navigationController = currentViewController?.navigationController  {
            _ = navigationController.rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
            guard navigationController.popViewController(animated: animated) != nil else {
                fatalError("can't navigate back from \(String(describing: currentViewController))")
            }
            currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
        } else {
            fatalError("can't navigate back from \(String(describing: currentViewController))")
        }
        return subject
            .take(1)
            .ignoreElements()
            .asCompletable()
    }

    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
        let subject = PublishSubject<Void>.init()
        let viewController = scene.viewController()
        switch type {
        case .root:
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            window.rootViewController = viewController
            subject.onCompleted()
        case .push:
            guard let navigationController = currentViewController?.navigationController else {
                fatalError("can't navigate back from \(String(describing: currentViewController))")
            }
            let _ = navigationController.rx.delegate.sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map { _ in }
                .bind(to: subject)
            navigationController.pushViewController(viewController, animated: true)
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
        case .model:
            viewController.modalPresentationStyle = .fullScreen
            currentViewController?.present(viewController, animated: true, completion: {
                subject.onCompleted()
            })
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
        }
        return subject
            .take(1)
            .ignoreElements()
            .asCompletable()
    }
}
