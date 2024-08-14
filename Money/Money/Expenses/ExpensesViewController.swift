//
//  ExpensesViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import UIKit
import SnapKit

class ExpensesViewController: UIViewController, UITableViewDelegate {

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
    
//    private lazy var table: UITableView = {
//        let table = UITableView()
//        
//        return table
//    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupTableView()
        setupUI()
    }
    
    // MARK: - Private Methods
//    private func setupTableView() {
//        table.register(ExpensesTableViewCell.self, forCellReuseIdentifier: "ExpensesTableViewCell")
//        table.dataSource = self
//        table.delegate = self
//        table.frame = view.bounds
//    }
    
    private func setupUI() {
        // table
        [countLabel, monthLabel].forEach { view.addSubview($0) }
        view.backgroundColor = .white
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
        
//        table.snp.makeConstraints { make in
//            make.top.equalTo(monthLabel.snp.bottom).offset(20)
//            make.trailing.leading.bottom.equalToSuperview().inset(10)
//        }
    }
}

// MARK: - UITableViewDataSourse
extension ExpensesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpensesTableViewCell",
                                                 for: indexPath) as? ExpensesTableViewCell
        return cell ?? UITableViewCell()
    }
    
    
}
