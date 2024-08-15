//
//  ExpensesViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import UIKit
import SnapKit

final class ExpensesViewController: UIViewController {
    
    // MARK: - GUI Variables
    
    // Все элементы инитятся сразу, лейзи не нужен. Не изменяются - используем let
    private let table = UITableView()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        // могу посоветовать выносить константы в отдельное расширение, что бы если что-то в будущем нужно будет изменить не бегать по элементам, все будет в одном месте
        label.text = Constants.Texts.countLabelText
        label.font = .boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.monthLabelText
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.Texts.buttonTitle, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 40)
        button.backgroundColor = .lightGray
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = CGFloat(Constants.Sizes.buttonHeight / 2)
        button.addTarget(nil, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    private var viewModel: ExpensesViewModelProtocol?
    
    // MARK: - Life Cycle
    init(viewModel: ExpensesViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupUI()
    }
    
    private func setupViewModel() { }
}

// MARK: - Private

private extension ExpensesViewController {

    @objc 
    func addButtonTapped() {
        let addExpenseVC = AddExpensesViewController()
        addExpenseVC.delegate = self
        present(addExpenseVC, animated: true, completion: nil)
    }

    private func setupTableView() {
        table.register(ExpensesTableViewCell.self, forCellReuseIdentifier: ExpensesTableViewCell.reuseID)
        table.dataSource = self
        table.delegate = self
//        table.frame = view.bounds
//        table.separatorStyle = .none
    }

    func setupUI() {
        [countLabel, monthLabel, table, plusButton].forEach { view.addSubview($0) }
        view.backgroundColor = .white

        setupConstraints()
    }

    func setupConstraints() {
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(70)
            make.leading.trailing.equalToSuperview()
        }

        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }

        table.snp.makeConstraints { make in
            make.top.equalTo(monthLabel.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(10)
            make.height.equalTo(400)
        }

        plusButton.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.Sizes.buttonHeight)
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(table.snp.bottom).offset(20)
        }
    }
}

// MARK: - UITableViewDelegate

extension ExpensesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

// MARK: - UITableViewDataSourse

extension ExpensesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.sections[section].items.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpensesTableViewCell.reuseID,
                                                       for: indexPath) as? ExpensesTableViewCell else {
            return UITableViewCell()
        }
        if let expense = viewModel?.sections[indexPath.section].items[indexPath.row] as? ExpensesObject {
            cell.configure(with: expense)
        }
        return cell
    }
}

// MARK: - AddExpensesViewControllerDelegate
// Передадим данные через делегат контроллера

extension ExpensesViewController: AddExpensesViewControllerDelegate {
    
    func didAddExpense(_ expense: ExpensesObject) {
        viewModel?.addExpenses(expense)
        // передаем во вью модель данные
    }
}

// MARK: - UI constants

private extension ExpensesViewController {

    enum Constants {

        enum Texts {
            static let countLabelText = "Count"
            static let monthLabelText = "was saved in this month"
            static let buttonTitle = "+"
        }

        enum Sizes {
            static let buttonHeight: CGFloat = 70.0
        }
    }
}
