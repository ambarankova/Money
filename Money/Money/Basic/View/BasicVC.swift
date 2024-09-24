//
//  BasicVC.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.09.2024.
//

import SnapKit
import UIKit

class BasicVC: UIViewController {
    // MARK: - GUI Variables
    let table = UITableView()
    
    var countLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.countLabelText
        label.font = .boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    var monthLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.monthLabelText
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    let clearButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.Texts.buttonTitle, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = .lightGray
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = CGFloat(Constants.Sizes.buttonHeight / 2)
        button.titleLabel?.numberOfLines = 2
        button.addTarget(nil, action: #selector(clearButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    var viewModel: MainTransactionViewModelProtocol?
    
    // MARK: - Life Cycle
    init(viewModel: MainTransactionViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        let countInt = viewModel.count
        countLabel.text = String(countInt)

        if countInt < 0 {
            monthLabel.text = "keep an eye on the budget"
        }
        
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Private
extension BasicVC {
        @objc func clearButtonTapped() {
    //        let addExpenseVC = AddExpensesViewController()
    //        addExpenseVC.delegate = self
    //        present(addExpenseVC, animated: true, completion: nil)
        }

    //// MARK: - AddExpensesViewControllerDelegate
    //extension BasicTransactionVC: AddExpensesViewControllerDelegate {
    //    func didAddExpense(_ expense: TransactionObject) {
    //        viewModel?.addExpenses(expense)
    //    }
    //}

    private func setupViewModel() {
        viewModel?.reloadTable = { [weak self] in
            self?.table.reloadData()
        }
    }
    
    private func registerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: NSNotification.Name("Update"), object: nil)
    }
    
    @objc private func updateData() {
        table.reloadData()
    }
    
    private func setupTableView() {
        table.register(MainTransactionTableViewCell.self, forCellReuseIdentifier: MainTransactionTableViewCell.reuseID)
        table.dataSource = self
        table.delegate = self
    }
    
    func setupUI() {
        [countLabel, monthLabel, table, clearButton].forEach { view.addSubview($0) }
        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    func setupConstraints() {
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
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
        
        clearButton.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.Sizes.buttonHeight)
            make.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
    }
}

// MARK: - UITableViewDelegate
extension BasicVC: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSourse
extension BasicVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UI constants
private extension BasicVC {
    enum Constants {
        enum Texts {
            static let countLabelText = "Count"
            static let monthLabelText = "keep it up!"
            static let buttonTitle = "new month"
        }
        enum Sizes {
            static let buttonHeight: CGFloat = 70.0
        }
    }
}

