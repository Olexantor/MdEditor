//
//  TodoListViewController.swift
//  TodoList
//
//  Created by Kirill Leonov on 28.11.2023.
//

import UIKit

/// Протокол главного экрана приложения.
protocol ITodoListViewController: AnyObject {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: TodoListModel.ViewModel)
}

/// Главный экран приложения.
final class TodoListViewController: UITableViewController {

	// MARK: - Dependencies

	var interactor: ITodoListInteractor?

	// MARK: - Private properties

	private var viewModel = TodoListModel.ViewModel(tasksBySections: [])

	// MARK: - Initialization

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		interactor?.fetchData()
	}
}

// MARK: - UITableView

extension TodoListViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.tasksBySections.count
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		
		let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width - 30, height: 30))
		label.text = viewModel.tasksBySections[section].title
		label.textColor = UIColor.systemGray
		label.font = UIFont.boldSystemFont(ofSize: 17)
		label.accessibilityIdentifier = AccessibilityIdentifier.TodoListScene.sectionID(
						section: section
   		).description
		
		headerView.addSubview(label)
		
		return headerView
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewModel.tasksBySections[section]
		return section.tasks.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let task = getTaskForIndex(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: L10n.TodoList.cellId, for: indexPath)
		cell.accessibilityIdentifier = AccessibilityIdentifier.TodoListScene.cellID(
				section: indexPath.section,
				row: indexPath.row
		).description
		configureCell(cell, with: task)
		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didTaskSelected(request: TodoListModel.Request.TaskSelected(indexPath: indexPath))
	}
}

// MARK: - UI setup

private extension TodoListViewController {

	private func setupUI() {
        view.backgroundColor = Theme.backgroundColor
        title = L10n.Todolist.text
		navigationController?.navigationBar.prefersLargeTitles = true

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: L10n.TodoList.cellId)
	}

	func getTaskForIndex(_ indexPath: IndexPath) -> TodoListModel.ViewModel.Task {
		let tasks = viewModel.tasksBySections[indexPath.section].tasks
		let task = tasks[indexPath.row]
		return task
	}

	func configureCell(_ cell: UITableViewCell, with task: TodoListModel.ViewModel.Task) {
		var contentConfiguration = cell.defaultContentConfiguration()

        cell.tintColor = Colors.red
		cell.selectionStyle = .none

		switch task {
		case .importantTask(let task):
            let violetColorAttribute = [NSAttributedString.Key.foregroundColor: Colors.red]
            let blackColorAttribute = [NSAttributedString.Key.foregroundColor: Theme.black]
			let taskText = NSMutableAttributedString(
                string: task.priority + " ",
                attributes: violetColorAttribute
            )
            let taskTitle = NSAttributedString(string: task.title, attributes: blackColorAttribute)
			taskText.append(taskTitle)

			contentConfiguration.attributedText = taskText
			contentConfiguration.secondaryText = task.deadLine
			cell.accessoryType = task.completed ? .checkmark : .none
		case .regularTask(let task):
			contentConfiguration.text = task.title
            contentConfiguration.textProperties.color = Theme.black
			cell.accessoryType = task.completed ? .checkmark : .none
		}

		cell.contentConfiguration = contentConfiguration
        cell.backgroundColor = .clear
	}
}

// MARK: - IMainViewController

extension TodoListViewController: ITodoListViewController {

	/// Метод отрисовки информации на экране.
	/// - Parameter viewModel: данные для отрисовки на экране.
	func render(viewModel: TodoListModel.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}
