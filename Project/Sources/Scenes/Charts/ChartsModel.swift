//
//  ChartsModel.swift
//  TodoList
//

import Foundation
// swiftlint:disable nesting
enum ChartsModel {

	struct Response {
		let data: Tasks

		struct Tasks {
			let all: Int
			let completed: Int
			let uncompleted: Int
		}
	}

	struct ViewModel {
		let segment: [Segment]

		struct ChartSegment {
			let title: String
			let value: Float
		}

		enum Segment {
			case completed(ChartSegment)
			case uncompleted(ChartSegment)
		}
	}
}
// swiftlint:enable nesting
