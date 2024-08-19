//
//  ExpTransactionViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 15.08.2024.
//

import SnapKit
import UIKit

final class ExpTransactionViewController: UIViewController {
    // MARK: - GUI Variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Transactions"
        label.font = .boldSystemFont(ofSize: 40)
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
    
    private lazy var table = UITableView()
    
    // MARK: - Properties
    private var viewModel: ExpTransactionViewModelProtocol?
    
    // MARK: - Life Cycle
    init(viewModel: ExpTransactionViewModelProtocol) {
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
}

// MARK: - Private
private extension ExpTransactionViewController {
    func setupViewModel() {
        viewModel?.reloadTable = { [weak self] in
            self?.table.reloadData()
        }
    }
    
    func setupTableView() {
        table.register(ExpTransactionTableViewCell.self, forCellReuseIdentifier: ExpTransactionTableViewCell.reuseID)
        table.dataSource = self
        table.delegate = self
    }
    
    func setupUI() {
        [titleLabel, table, plusButton].forEach { view.addSubview($0) }
        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        table.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
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

// MARK: - Private
extension ExpTransactionViewController {
    @objc func addButtonTapped() {
        let addExpenseVC = AddExpensesViewController()
        addExpenseVC.delegate = self
        present(addExpenseVC, animated: true, completion: nil)
    }
}

// MARK: - AddExpensesViewControllerDelegate
extension ExpTransactionViewController: AddExpensesViewControllerDelegate {
    func didAddExpense(_ expense: ExpensesObject) {
        viewModel?.addExpenses(expense)
    }
}

// MARK: - UITableViewDelegate
extension ExpTransactionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: - UITableViewDataSourse
extension ExpTransactionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.sections[section].items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpTransactionTableViewCell",
                                                       for: indexPath) as? ExpTransactionTableViewCell,
              let expense = viewModel?.sections[indexPath.section].items[indexPath.row] as? ExpensesObject
        else { return UITableViewCell() }
        
        cell.configure(with: expense)
        return cell
    }
}

// MARK: - UI constants
private extension ExpTransactionViewController {
    enum Constants {
        enum Texts {
            static let buttonTitle = "+"
        }
        enum Sizes {
            static let buttonHeight: CGFloat = 70.0
        }
    }
}

