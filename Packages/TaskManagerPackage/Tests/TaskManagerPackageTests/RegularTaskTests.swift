//
//  File.swift
//  
//
//  Created by Александр Николаев on 19.09.2024.
//

import XCTest
@testable import TaskManagerPackage

final class RegularTaskTests: XCTestCase {
    func test_init_withTitLeAndCompleted_shouldHaveCorrect() {
        let sut = RegularTask(title: title, completed: true)
        
        XCTAssertEqual(sut.title, title, "Не совпадает имя задания с переданным в инициализатор.")
        XCTAssertTrue(sut.completed, "Задание должно было создаться выполненным.")
    }

    func test_init_defaultCompleted_propertyCompletedShouldBeFalse(){
        let sut = RegularTask(title: title)
        
        XCTAssertFalse(sut.completed, "Задание должно было создаться выполненным.")
    }
    func test_init_withTitleNotCompleted_shouldHaveCorrect(){
        let sut = RegularTask(title: title, completed: false)
        
        XCTAssertEqual(sut.title, title, "Не совпадает имя задания с переданным в инициализатор.")
        XCTAssertFalse(sut.completed, "Задание должно было создаться выполненным.")
    }
    
    func test_completed_togglePropertyCompleted_propertyCompletedShouldBeTrue() {
        let sut = RegularTask(title: title, completed: false)
        
        sut.completed.toggle()
        XCTAssertTrue(sut.completed, "Задание должно было стать выполненным.")
    }

}

// MARK: - TestData

private extension RegularTaskTests {
    var title: String {
        "Regular Test Task"
    }
}
