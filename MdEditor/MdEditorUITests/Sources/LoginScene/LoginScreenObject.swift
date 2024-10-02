//
//  LoginScreenObject.swift
//  MdEditor
//
//  Created by Александр Николаев on 01.10.2024.
//  Copyright © 2024 MyTeam. All rights reserved.
//

import Foundation
import XCTest

final class LoginScreenObject: BaseScreenObject {
    
    // MARK: - Private properties
    
	private lazy var textFieldLogin = app.textFields[
		AccessibilityIdentifier.LoginScene.textFieldLogin.description
	]
    private lazy var textFieldPass = app.secureTextFields[
		AccessibilityIdentifier.LoginScene.textFieldPass.description
	]
    private lazy var loginButton = app.buttons[
		AccessibilityIdentifier.LoginScene.buttonLogin.description
	]
    
    // MARK: - ScreenObject Methods

    @discardableResult
    func isLoginScreen() -> Self {
        assert(textFieldLogin, [.exists])
        assert(textFieldPass, [.exists])
        assert(loginButton, [.exists])
        
        return self
    }
    
    @discardableResult
    func set(login: String) -> Self {
        assert(textFieldLogin, [.exists])
        textFieldLogin.tap()
        textFieldLogin.typeText(login)
        
        return self
    }
    
    @discardableResult
    func set(password: String) -> Self {
        assert(textFieldPass, [.exists])
        textFieldPass.tap()
        textFieldPass.typeText(password)
        
        return self
    }
    
    @discardableResult
    func login() -> Self {
        assert(loginButton, [.exists])
        loginButton.tap()
        
        return self
    }
	
	@discardableResult
	func openScreenCheck() -> Self {
		XCTAssertTrue(app.wait(for: .runningForeground, timeout: 3))
		assert(textFieldLogin, [.doesNotExist])
		return self
	}
	
	@discardableResult
	func checkAlertWith(message: String) -> Self {
		assert(alert, [.exists])
		let alertMessage = alert.staticTexts[message]
		assert(alertMessage, [.contains(message)])
		let okButton = alert.buttons["Ok"]
		assert(okButton, [.exists])
		okButton.tap()
		XCTAssertTrue(app.wait(for: .runningForeground, timeout: 3))
		assert(textFieldLogin, [.exists])
		return self
	}
}
