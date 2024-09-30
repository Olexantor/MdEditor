//
//  MainCoordinator.swift
//  TodoList
//

import UIKit
import TaskManagerPackage

final class MainCoordinator: BaseCoordinator {

	// MARK: - Dependencies

	private let tabBarController: UITabBarController
	private var taskManager: ITaskManager! // swiftlint:disable:this implicitly_unwrapped_optional

	// MARK: - Private properties

	private let pages: [TabbarPage] = TabbarPage.allTabbarPages

	// MARK: - Initialization

	init(tabBarController: UITabBarController) {
		self.tabBarController = tabBarController
	}

	// MARK: - Internal methods

	override func start() {
		tabBarController.viewControllers?.enumerated().forEach { item in
			guard let controller = item.element as? UINavigationController else { return }
			runFlowByIndex(item.offset, on: controller)
		}
	}
}

// MARK: - run Flows -
private extension MainCoordinator {
	func runFlowByIndex(_ index: Int, on controller: UINavigationController) {
        let repository = TaskRepositoryStub()
        taskManager = OrderedTaskManager(taskManager: TaskManager())
        taskManager.addTasks(tasks: repository.getTasks())
		let coordinator: ICoordinator

		switch pages[index] {
		case .todoList:
			coordinator = TodoListCoordinator(
				navigationController: controller,
				taskManager: taskManager
			)
		case .chart:
			coordinator = ChartsCoordinator(
				navigationController: controller,
				taskManager: taskManager
			)
		}
		addDependency(coordinator)
		coordinator.start()
	}
}
