//
//  TodoListCoordinator.swift
//  TodoList
//

import UIKit
import TaskManagerPackage

final class TodoListCoordinator: ICoordinator {

	// MARK: - Dependencies

	private let navigationController: UINavigationController
	private let taskManager: ITaskManager

	// MARK: - Initialization

	init(navigationController: UINavigationController, taskManager: ITaskManager) {
		self.navigationController = navigationController
		self.taskManager = taskManager
	}

	// MARK: - Internal methods

	func start() {
		showTodoListScene()
	}

	private func showTodoListScene() {

		let assembler = TodoListAssembler(taskManager: taskManager)
		let viewController = assembler.assembly()
		navigationController.pushViewController(viewController, animated: true)
	}
}
