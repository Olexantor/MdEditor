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
	private lazy var tableView = app.tables[AccessibilityIdentifier.TodoListScene.table.description]
	
	// MARK: - ScreenObject Methods
	@discardableResult
	func isTodoListScreen() -> Self {
		checkTitle(contains: L10n.Todolist.text)
		assert(tableView, [.exists])
		
		return self
	}
	
	@discardableResult
	func checkSectionsTitle(index: Int, title: String) -> Self {
		let section = getSection(index: index)
		XCTAssertEqual(section.label, title, "Title section \(index) should be equal '\(title)'")
		return self
	}
	
	@discardableResult
	func checkCellTitle(section: Int, row: Int, title: String) -> Self {
		let cell = getCell(section: section, row: row)
		assert(cell, [.exists])
		
		let titleTaskLabel = cell.staticTexts.element(boundBy: 0).label
		let contains = titleTaskLabel.contains(title)
		
		XCTAssertTrue(contains, "Title task \(titleTaskLabel) should be equal '\(title)'")
		
		return self
	}
	
	@discardableResult
	func checkCellDeadLine(section: Int, row: Int, deadline: String) -> Self {
		let cell = getCell(section: section, row: row)
		assert(cell, [.exists])
		
		let deadlineTask = cell.staticTexts.element(boundBy: 1).label
		let isDeadlineTaskContain = deadlineTask.contains(deadline)
		XCTAssertTrue(isDeadlineTaskContain, "Cell [\(section):\(row)] should contain '\(deadline)")
		return self
	}
	
	@discardableResult
	func tapOnCell(section: Int, row: Int) -> Self {
		let cell = getCell(section: section, row: row)
		assert(cell, [.exists])
		cell.tap()
		
		return self
	}
	
	@discardableResult
	func checkCountOfSelectedItems(_ count: Int) -> Self {
		assert(tableView, [.exists])
		let selected = tableView.children(matching: .cell).allElementsBoundByIndex.filter { $0.isSelected }
		XCTAssertEqual(selected.count, count, "Количество выбранных ячеек не соответствует ожидаемому \(count)")
		
		return self
	}
	
	@discardableResult
	func checkCountOfNotSelectedItems(_ count: Int) -> Self {
		assert(tableView, [.exists])
		let selected = tableView.children(matching: .cell).allElementsBoundByIndex.filter { !$0.isSelected }
		XCTAssertEqual(selected.count, count, "Количество невыбранных ячеек не соответствует ожидаемому \(count)")
		
		return self
	}
}

private extension TodoListScreenObject {
	func getSection(index: Int) -> XCUIElement {
		tableView.otherElements[AccessibilityIdentifier.TodoListScene.section(index).description]
	}
	
	func getCell(section: Int, row: Int) -> XCUIElement {
		tableView.cells[AccessibilityIdentifier.TodoListScene.cell(section: section, row: row).description]
	}
}
