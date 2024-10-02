//
//  LoginSceneUITest.swift
//  MdEditor
//
//  Created by Александр Николаев on 01.10.2024.
//  Copyright © 2024 MyTeam. All rights reserved.
//

import XCTest

final class LoginSceneUITest: XCTestCase {
	
	var app: XCUIApplication!
	
	override func setUp() {
		app = XCUIApplication()
		app.launchArguments = ["-AplleLanguages", "(en)"]
	}
	
	override func tearDown() {
		app = nil
	}

	func test_login_withValidCred_mustBeSuccess() {
		let loginScreen = LoginScreenObject(app: app)
		app.launch()
	
		loginScreen
			.isLoginScreen()
			.set(login: "Admin")
			.set(password: "pa$$32!")
			.login()
			.openScreenCheck()
	}
	
	func test_login_withEmptyFieds_mustBeFailWithAlert() {
		let loginScreen = LoginScreenObject(app: app)
		app.launch()
	
		loginScreen
			.isLoginScreen()
			.login()
			.checkAlertWith(message: L10n.Login.emptyFields)
	}
	
	func test_login_withInvalidLogin_mustBeFailWithAlert() {
		let loginScreen = LoginScreenObject(app: app)
		app.launch()
	
		loginScreen
			.isLoginScreen()
			.set(login: "x")
			.set(password: "pa$$32!")
			.login()
			.checkAlertWith(message: L10n.Login.invalidLogin)
	}
	
	func test_login_withInvalidPassword_mustBeFailWithAlert() {
		let loginScreen = LoginScreenObject(app: app)
		app.launch()
	
		loginScreen
			.isLoginScreen()
			.set(login: "Admin")
			.set(password: "x")
			.login()
			.checkAlertWith(message: L10n.Login.invalidPassword)
	}
	
	func test_login_withInvalidCredentials_mustBeFailWithAlert() {
		let loginScreen = LoginScreenObject(app: app)
		app.launch()
	
		loginScreen
			.isLoginScreen()
			.set(login: "x")
			.set(password: "x")
			.login()
			.checkAlertWith(message: L10n.Login.errorAuthorization)
	}
}

