//
//  SceneDelegate.swift
//  TestProj
//
//  Created by Александр Николаев on 30.08.2024.
//

import UIKit
import TaskManagerPackage

protocol IAppFactory {
    func makeKeyWindowWithCoordinator(scene: UIWindowScene) -> (UIWindow, ICoordinator)
}

extension IAppFactory {
    func makeKeyWindowWithCoordinator(scene: UIWindowScene) -> (UIWindow, ICoordinator) {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true

        let window = UIWindow(windowScene: scene)
        let coordinator = AppCoordinator(navigationController: navigationController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return (window, coordinator)
    }
}

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: ICoordinator! // swiftlint:disable:this implicitly_unwrapped_optional

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        (window, appCoordinator) = makeKeyWindowWithCoordinator(scene: scene)

        appCoordinator.start()
    }
}

extension SceneDelegate: IAppFactory {}
