//
//  ITestCoordinator.swift
//  MdEditorUITests
//
//  Created by Александр Николаев on 06.10.2024.
//  Copyright © 2024 MyTeam. All rights reserved.
//

protocol ITestCoordinator: AnyObject {
	func testStart(paremeters: [LaunchArguments: Bool])
}
