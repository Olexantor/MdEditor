//
//  ConfigureTestEnvironment.swift
//  MdEditorUITests
//
//  Created by Александр Николаев on 06.10.2024.
//  Copyright © 2024 MyTeam. All rights reserved.
//

import Foundation

enum ConfigureTestEnvironment {
	
	static let lang = ["AplleLanguages", "(en)"]
	static let skipLogin = ["-skipLogin"]
	
	enum ValidCredentials {
		static let login = "Admin"
		static let password = "pa$$32!"
	}
	
	enum InvalidCredentials {
		static let login = "pa$$32!"
		static let password = "Admin"
	}
}
