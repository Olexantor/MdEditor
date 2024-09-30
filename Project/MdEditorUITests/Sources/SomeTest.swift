//
//  SomeTest.swift
//  MdEditorUITests
//
//  Created by Александр Николаев on 28.09.2024.
//  Copyright © 2024 MyTeam. All rights reserved.
//
// swiftlint:disable line_length
import XCTest

final class SomeTest: XCTestCase {

    override func setUp() {
        let app = XCUIApplication()

        /// аргументы - то что передается через терминал, входные параметры команды (ls -a)
        /// Здесь у нас массив строк
        /// -enableTesting - отключит анимации для ускорения тестов
        app.launchArguments = [LaunchArguments.enableTesting.rawValue]
        app.launchArguments = LaunchArguments.russianLanguage
        /// А это у нас словарь
        /// Это то самое окружение, которое мы добавляем в BuildPhases
        app.launchEnvironment = LaunchArguments.serverUrl

        app.launch()
    }

            func testMethod1() {
                let app = XCUIApplication()
                let loginTF = app.textFields["Login"]
            
                loginTF.tap()
                loginTF.typeText("Admin")

                app.secureTextFields["Password"].tap()

                let pKey = app/*@START_MENU_TOKEN@*/.keys["p"]/*[[".keyboards.keys[\"p\"]",".keys[\"p\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
                pKey.tap()

                let a2Key = app.keys["a"]
                a2Key.tap()

                let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"numbers\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
                moreKey.tap()

                let dolKey = app/*@START_MENU_TOKEN@*/.keys["$"]/*[[".keyboards.keys[\"$\"]",".keys[\"$\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
                dolKey.tap()
                dolKey.tap()

                let key3 = app/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
                key3.tap()

                let key2 = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
                key2.tap()

                app.buttons["buttonLogin"].tap()
                app.alerts["Error"].scrollViews.otherElements.buttons["Ok"].tap()
    }
}
// swiftlint:enable line_length
