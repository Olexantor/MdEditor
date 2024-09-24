//
//  OrderedTaskManagerTests.swift
//  
//
//  Created by Александр Николаев on 17.09.2024.
//

import XCTest
@testable import TaskManagerPackage

final class OrderedTaskManagerTests: XCTestCase {

    func test_allTasks_shouldBe5TaskOrderedByPriority() {
        // Arrange
        let sut = makeSut(.sort)
        let validResultTasks: [TaskManagerPackage.Task] = [
            MockTaskManager.highImportantTask,
            MockTaskManager.mediumImportantTask,
            MockTaskManager.lowImportantTask,
            MockTaskManager.completedRegularTask,
            MockTaskManager.uncompletedRegularTask
        ]
        
        // Act
        let resultTasks = sut.allTasks()
        
        // Assert
        XCTAssertEqual(resultTasks.count, 5, "При выборке всех задач, ожидалось, что их будет 5 штук.")
        XCTAssertEqual(
            resultTasks,
            validResultTasks,
            "При выборке всех задач, порядок задач не совпал с сортировкой по приоритету."
        )

    }
    
    func test_completedTasks_shouldBeAllCompletedTaskOrderedByPriority() {
        // Arrange
        let sut = makeSut(.sort)
        let validResultTasks: [TaskManagerPackage.Task] = [MockTaskManager.completedRegularTask]
        
        // Act
        let resultTasks = sut.completedTasks()
        
        // Assert
        XCTAssertEqual(resultTasks.count, 1, "При выборке завершенных задач, ожидалось, что их будет 1 штука.")
        XCTAssertEqual(
            resultTasks,
            validResultTasks,
            "При выборке завершенных задач, порядок задач не совпал с сортировкой по приоритету."
        )
    }
    
    func test_uncompletedTasks_shouldBeAllUncompletedTaskOrderedByPriority() {
        // Arrange
        let sut = makeSut(.sort)
        let validResultTasks: [TaskManagerPackage.Task] = [
            MockTaskManager.highImportantTask,
            MockTaskManager.mediumImportantTask,
            MockTaskManager.lowImportantTask,
            MockTaskManager.uncompletedRegularTask,
        ]
        
        // Act
        let resultTasks = sut.uncompletedTasks()
        
        // Assert
        XCTAssertEqual(resultTasks.count, 4, "При выборке незавершенных задач, ожидалось, что их будет 4 штуки.")
        XCTAssertEqual(
            resultTasks,
            validResultTasks,
            "При выборке незавершенных задач, порядок задач не совпал с сортировкой по приоритету."
        )
    }
    
    func test_addTask_addOneTask_countShouldBeEqualOne() {
        let sut = makeSut(.addOrRemove)
        sut.addTask(task: MockTaskManager.completedRegularTask)
        
        let result = sut.allTasks().count
        
        XCTAssertEqual(result, 1, "Ожидалось, что счетчик будет равен 1")
    }
    
    func test_addTasks_addThreeTasks_countShouldBeEqualThree() {
        let sut = makeSut(.addOrRemove)
        let tasks = [
            MockTaskManager.highImportantTask,
            MockTaskManager.mediumImportantTask,
            MockTaskManager.lowImportantTask
            ]
        sut.addTasks(tasks: tasks)
        
        let result = sut.allTasks().count
        
        XCTAssertEqual(result, 3, "Ожидалось, что счетчик будет равен 3")
    }
    
    func test_removeTask_removeOneTask_countShouldBeEqualZero() {
        let sut = makeSut(.addOrRemove)
        let task = MockTaskManager.completedRegularTask
        sut.addTask(task: task)
        sut.removeTask(task: task)
        
        let count = sut.allTasks().count
        let isEmpty = sut.allTasks().isEmpty
        
        
        XCTAssertEqual(count, 0, "Ожидалось, что счетчик будет равен 0")
        XCTAssertTrue(isEmpty, "Массив Tasks должен быть пуст")
    }
}

// MARK: - TestData

private extension OrderedTaskManagerTests {
    
    enum Action {
        case sort
        case addOrRemove
    }
    
    func makeSut(_ action: Action) -> OrderedTaskManager {
        
        switch action {
        case .sort:
            let mockTaskManager = MockTaskManager()
            return OrderedTaskManager(taskManager: mockTaskManager)
        case .addOrRemove:
            let mockTaskManager2 = MockTaskManager2()
            return OrderedTaskManager(taskManager: mockTaskManager2)
        }
    }
}
