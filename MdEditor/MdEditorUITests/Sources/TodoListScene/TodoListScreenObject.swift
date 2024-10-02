//
//  TodoListScreenObject.swift
//  MdEditor
//
//  Created by Александр Николаев on 02.10.2024.
//  Copyright © 2024 MyTeam. All rights reserved.
//

import Foundation
import XCTest

final class TodoListScreenObject: BaseScreenObject {
	
	// MARK: - Private properties
	private lazy var loginButton = app.buttons[
		AccessibilityIdentifier.LoginScene.buttonLogin.description
	]
	private lazy var todoListFirstTabBarButton = app.tabBars.buttons.matching(identifier:
		AccessibilityIdentifier.TodoListScene.tabBarPage(index: 1).description
	).element
	
	// MARK: - Private methods
	private func getTableViewCellSection(identifier: String) -> XCUIElement  {
		app.staticTexts[identifier]
	}
	
	private func getTableViewCell(cellID: String) -> XCUIElement {
		app.tables.cells.matching(
			identifier: cellID
		).element
	}

	private func getTableViewCellsOf(section: Int) -> [XCUIElement] {
		app.tables.tabGroups.element(boundBy: section).cells.allElementsBoundByIndex
	}
	
	// MARK: - TodoListScreenObject Methods
	
	@discardableResult
	func login() -> Self {
		assert(loginButton, [.exists])
		loginButton.tap()
		XCTAssertTrue(app.wait(for: .runningForeground, timeout: 3))
		return self
	}
	
	@discardableResult
	func istodoListScreen() -> Self {
		assert(todoListFirstTabBarButton, [.exists])
		return self
	}
	
	@discardableResult
	func checkHeader(id: String, title: String) -> Self {
		let sectionHeader = getTableViewCellSection(identifier: id)
		assert(sectionHeader, [.exists])
		assert(sectionHeader, [.contains(title)])
		return self
	}
	
	@discardableResult
	func check_cell(id: String, text: String) -> Self {
		let cell = getTableViewCell(cellID: id)
		assert(cell, [.exists])
		assert(cell.staticTexts.firstMatch, [.contains(text)])
		return self
	}
	
	func checkCellCountAfterTap(in section: Int, tappedCellID: String) -> Self {
		let cellInSectionCount = getTableViewCellsOf(section: section).count
		let cell = getTableViewCell(cellID: tappedCellID)
		cell.tap()
		let cellsInSectionCountAfterTap = getTableViewCellsOf(section: section).count
		XCTAssertNotEqual(cellInSectionCount, cellsInSectionCountAfterTap)
		return self
	}
}
