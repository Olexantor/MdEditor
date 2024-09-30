//
//  LaunchArguments.swift
//  MdEditor
//
//  Created by Александр Николаев on 29.09.2024.
//  Copyright © 2024 MyTeam. All rights reserved.
//

import Foundation

enum LaunchArguments: String {
    case enableTesting = "-enableTesting"
    static let serverUrl = ["serverUrl": "swiftbook.ru"]
    static let englishLanguage = ["-AplleLanguages", "(en)"]
    static let russianLanguage = ["-AplleLanguages", "(ru)"]
}
