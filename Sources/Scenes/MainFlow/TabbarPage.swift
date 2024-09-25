import UIKit

enum TabbarPage {
	case todoList
	case chart

	func pageTitleValue() -> String {
		switch self {
		case .todoList:
            return L10n.todolist
		case .chart:
            return L10n.statistics
		}
	}

	func pageIconValue() -> UIImage {
		switch self {
		case .todoList:
			return Images.image(kind: .list)
		case .chart:
			return Images.image(kind: .chart)
		}
	}

	static let allTabbarPages: [TabbarPage] = [.todoList, .chart]
	static let firstTabbarPage: TabbarPage = .todoList

	var pageOrderNumber: Int {
		guard let num = TabbarPage.allTabbarPages.firstIndex(of: self) else { return .zero }
		return num
	}
}
