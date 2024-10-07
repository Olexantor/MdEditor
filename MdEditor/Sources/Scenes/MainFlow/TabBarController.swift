import UIKit

final class TabBarController: UITabBarController {

	// MARK: - LifeCycle -

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}
}

private extension TabBarController {
	func setup() {
		let controllers: [UINavigationController] = TabbarPage.allTabbarPages
			.enumerated()
			.map { index, tabBarPage in
				getTabController(tabBarPage, index)
			}

		setViewControllers(controllers, animated: true)
		selectedIndex = TabbarPage.firstTabbarPage.pageOrderNumber
	}

	func getTabController(_ page: TabbarPage, _ index: Int) -> UINavigationController {
		let navController = UINavigationController()

		navController.tabBarItem = UITabBarItem(
			title: page.pageTitleValue(),
			image: page.pageIconValue(),
			tag: page.pageOrderNumber
		)
		
		navController.tabBarItem.accessibilityIdentifier = AccessibilityIdentifier
			.TodoListScene
			.tabBarPage(index: index)
			.description

		return navController
	}
}
