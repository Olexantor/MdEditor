//
//  AppCoordinator.swift
//  TodoList
//

import UIKit
import TaskManagerPackage

final class AppCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController

	// MARK: - Initialization

    init(navigationController: UINavigationController) {
		self.navigationController = navigationController
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
	}

	func runMainFlow() {
		let tabBarController = TabBarController()
        let coordinator = MainCoordinator(tabBarController: tabBarController)
		addDependency(coordinator)
		coordinator.start()

		navigationController.isNavigationBarHidden = true
		navigationController.setViewControllers([tabBarController], animated: true)
	}
}

extension AppCoordinator: ITestCoordinator {
	func testStart(paremeters: [LaunchArguments: Bool]) {
		if let skipLogin = paremeters[LaunchArguments.skipLogin], skipLogin {
			runMainFlow()
		} else {
			runLoginFlow()
		}
	}
}
