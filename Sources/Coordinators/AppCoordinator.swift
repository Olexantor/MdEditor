//
//  AppCoordinator.swift
//  TodoList
//

import UIKit
import TaskManagerPackage

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private var window: UIWindow?
    private let taskManager: ITaskManager

	// MARK: - Initialization

    init(window: UIWindow?, navigationController: UINavigationController, taskManager: ITaskManager) {
		self.window = window
		self.navigationController = navigationController
        self.taskManager = taskManager
	}

	// MARK: - Internal methods

	override func start() {
		runLoginFlow()
	}

	func runLoginFlow() {
		let coordinator = LoginCoordinator(navigationController: navigationController)
		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			self?.runMainFlow()
			coordinator.map { self?.removeDependency($0) }
		}

		coordinator.start()

		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}

	func runMainFlow() {
		let tabBarController = TabBarController()
        let coordinator = MainCoordinator(tabBarController: tabBarController, taskManager: taskManager)
		addDependency(coordinator)
		coordinator.start()

		navigationController.isNavigationBarHidden = true
		navigationController.setViewControllers([tabBarController], animated: true)
	}
}
