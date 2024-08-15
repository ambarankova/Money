//
//  ExpensesViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import UIKit
import SnapKit

class ExpensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - GUI Variables
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Count"
        label.font = .boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        
        label.text = "was saved in this month"
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 40)
        button.backgroundColor = .lightGray
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = CGFloat(buttonHeight / 2)
        
        return button
    }()
    
    private lazy var table: UITableView = {
        let table = UITableView()
        
        return table
    }()
    
    // MARK: - Properties
    private var viewModel: ExpensesViewModelProtocol?
    private let buttonHeight = 70
    
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
    
    // MARK: - Private Methods
    private func setupViewModel() { }
    
    private func setupTableView() {
        table.register(ExpensesTableViewCell.self, forCellReuseIdentifier: "ExpensesTableViewCell")
        table.dataSource = self
        table.delegate = self
//        table.frame = view.bounds
//        table.separatorStyle = .none
    }
    
    private func setupUI() {
        [countLabel, monthLabel, table, plusButton].forEach { view.addSubview($0) }
        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    private func setupConstraints() {
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
            make.width.height.equalTo(buttonHeight)
            make.trailing.equalToSuperview().inset(40)
            make.top.equalTo(table.snp.bottom).offset(20)
        }
    }
    
    // MARK: - UITableViewDataSourse
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.sections[section].items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpensesTableViewCell",
                                                       for: indexPath) as? ExpensesTableViewCell,
              let expense = viewModel?.sections[indexPath.section].items[indexPath.row] as? ExpensesObject
        else { return UITableViewCell() }
        
        cell.set(expense: expense)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
