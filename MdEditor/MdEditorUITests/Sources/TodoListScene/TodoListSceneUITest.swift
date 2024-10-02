//
//  TodoListSceneUITest.swift
//  MdEditorUITests
//
//  Created by Александр Николаев on 02.10.2024.
//  Copyright © 2024 MyTeam. All rights reserved.
//

import XCTest

final class TodoListSceneUITest: XCTestCase {
	
	var app: XCUIApplication!
	
	override func setUp() {
		app = XCUIApplication()
		app.launchArguments = ["-AplleLanguages", "(en)"]
	}
	
	override func tearDown() {
		app = nil
	}
	
	
	func test_header_firstHeader_shouldHaveCorrectTitle() {
		let todoListScreen = TodoListScreenObject(app: app)
		app.launch()
		
		todoListScreen
			.login()
			.istodoListScreen()
			.checkHeader(
				id: AccessibilityIdentifier.TodoListScene.sectionID(section: 0).description,
				title: L10n.Uncompleted.text
			)
	}
	
	func test_header_secondHeader_shouldHaveCorrectTitle() {
		let todoListScreen = TodoListScreenObject(app: app)
		app.launch()
		
		todoListScreen
			.login()
			.istodoListScreen()
			.checkHeader(
				id: AccessibilityIdentifier.TodoListScene.sectionID(section: 1).description,
				title: L10n.Completed.text
			)
	}
	
	func test_cell_secondHeader_shouldHaveCorrectTitle() {
		let todoListScreen = TodoListScreenObject(app: app)
		app.launch()
		
		todoListScreen
			.login()
			.istodoListScreen()
			.checkHeader(
				id: AccessibilityIdentifier.TodoListScene.sectionID(section: 1).description,
				title: L10n.Completed.text
			)
	}
	
	func test_cell_text_shouldBeCorrect() {
		let todoListScreen = TodoListScreenObject(app: app)
		app.launch()
		
		todoListScreen
			.login()
			.istodoListScreen()
			.check_cell(
				id: AccessibilityIdentifier.TodoListScene.cellID(section: 1, row: 0).description,
				text: "Do Workout"
			)
	}
	
	func test_cellCount_inSection_shouldBeChangedAndCorrect() {
		let todoListScreen = TodoListScreenObject(app: app)
		app.launch()
		
		todoListScreen
			.login()
			.istodoListScreen()
			.checkCellCountAfterTap(
				in: 0,
				tappedCellID: AccessibilityIdentifier.TodoListScene.cellID(section: 1, row: 0).description
			)
	}
}
