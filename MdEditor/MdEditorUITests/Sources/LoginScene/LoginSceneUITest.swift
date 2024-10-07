//
//  LoginSceneUITest.swift
//  MdEditor
//
//  Created by Александр Николаев on 01.10.2024.
//  Copyright © 2024 MyTeam. All rights reserved.
//

import XCTest

final class LoginSceneUITest: XCTestCase {
	
	let app = XCUIApplication()
	lazy var screen = LoginScreenObject(app: app)
	
	override func setUp() {
		super.setUp()
		continueAfterFailure = false
		
		app.launch()
	}

	func test_login_withInvalidCredentials_mustBeSuccess() {

		screen
			.isLoginScreen()
			.set(login: ConfigureTestEnvironment.InvalidCredentials.login)
			.set(password: ConfigureTestEnvironment.InvalidCredentials.password)
			.login()
			.closeAlert()
			.isLoginScreen()
	}
	
	func test_login_withValidCredentials_mustBeSuccess() {
		
		let todoListSceneObject = TodoListScreenObject(app: app)

		screen
			.isLoginScreen()
			.set(login: ConfigureTestEnvironment.ValidCredentials.login)
			.set(password: ConfigureTestEnvironment.ValidCredentials.password)
			.login()
		// для прохождения данного теста на устройстве (Мак) должен быть английский
		todoListSceneObject.isTodoListScreen()
	}
}

