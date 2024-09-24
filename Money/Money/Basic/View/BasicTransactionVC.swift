//
//  BasicTransactionVC.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.09.2024.
//

import SnapKit
import UIKit

class BasicTransactionVC: UIViewController {
    // MARK: - GUI Variables
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Transactions"
        label.font = .boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.Texts.buttonTitle, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 40)
        button.backgroundColor = .lightGray
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = CGFloat(Constants.Sizes.buttonHeight / 2)
        button.addTarget(nil, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var table = UITableView()
    
    // MARK: - Properties
    var viewModel: TransactionViewModelProtocol?
    
    // MARK: - Life Cycle
    init(viewModel: TransactionViewModelProtocol) {
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
        registerObserver()
    }
}

// MARK: - Private
extension BasicTransactionVC {
    func setupViewModel() {
        viewModel?.reloadTable = { [weak self] in
            self?.table.reloadData()
        }
    }
    
    private func registerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: NSNotification.Name("Update"), object: nil)
    }
    
    @objc private func updateData() {
        viewModel?.getTransactions()
    }
    
    func setupTableView() {
        table.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.reuseID)
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
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
    }
}

// MARK: - Private
extension BasicTransactionVC {
    @objc func addButtonTapped() {
//        let addExpenseVC = AddExpensesViewController()
//        addExpenseVC.delegate = self
//        present(addExpenseVC, animated: true, completion: nil)
    }
}

//// MARK: - AddExpensesViewControllerDelegate
//extension BasicTransactionVC: AddExpensesViewControllerDelegate {
//    func didAddExpense(_ expense: TransactionObject) {
//        viewModel?.addExpenses(expense)
//    }
//}

// MARK: - UITableViewDelegate
extension BasicTransactionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let transaction = viewModel?.sections[indexPath.section].items[indexPath.row] as? TransactionObject else { return nil}
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, success) in
            print("Delete action")
            ExpensePersistant.delete(transaction)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - UITableViewDataSourse
extension BasicTransactionVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.sections[section].items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell",
                                                       for: indexPath) as? TransactionTableViewCell,
              let transaction = viewModel?.sections[indexPath.section].items[indexPath.row] as? TransactionObject
        else { return UITableViewCell() }
        
        cell.configure(with: transaction)
        return cell
    }
}

// MARK: - UI constants
private extension BasicTransactionVC {
    enum Constants {
        enum Texts {
            static let buttonTitle = "+"
        }
        enum Sizes {
            static let buttonHeight: CGFloat = 70.0
        }
    }
}

