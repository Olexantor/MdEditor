//
//  AccessibleIdentifier.swift
//  MdEditor
//
//  Created by Александр Николаев on 01.10.2024.
//  Copyright © 2024 MyTeam. All rights reserved.
//

import Foundation

enum AccessibilityIdentifier {
    
	enum LoginScene: CustomStringConvertible {
		
		case textFieldLogin
		case textFieldPass
		case buttonLogin
		
		var description: String {
			switch self {
			case .textFieldLogin:
				"loginScene.textFieldLogin"
			case .textFieldPass:
				"loginScene.textFieldPass"
			case .buttonLogin:
				"loginScene.buttonLogin"
			}
		}
    }
    
	enum TodoListScene: CustomStringConvertible {
		case table
		case section(Int)
		case cell(section: Int, row: Int)
		case tabBarPage(index: Int)
		
		var description: String {
			switch self {
			case .table:
				"todoListScene.table"
			case .section(let section):
				"todoListScene.cell-\(section)"
			case .cell(let section, let row):
				"cell-\(section)-\(row)"
			case .tabBarPage(let index):
				"todoListScene.section-\(index)"
			}
		}
    }
}
