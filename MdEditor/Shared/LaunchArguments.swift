//
//  LaunchArguments.swift
//  MdEditor
//
//  Created by Александр Николаев on 06.10.2024.
//  Copyright © 2024 MyTeam. All rights reserved.
//

enum LaunchArguments: String {
	case enableTesting = "-enableTesting"
	case skipLogin = "-skipLogin"
	
	static func parameters() -> [LaunchArguments: Bool] {
		var parameters = [LaunchArguments: Bool]()
		for argument in CommandLine.arguments {
			if let parameter = LaunchArguments(rawValue: argument) {
				parameters[parameter] = true
			}
		}
		return parameters
	}
}
