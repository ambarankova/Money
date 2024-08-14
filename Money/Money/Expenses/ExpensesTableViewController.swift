//
//  ExpensesTableViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import UIKit

final class ExpensesTableViewController: UITableViewController {
    private lazy var table: UITableView = {
        let table = UITableView()
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupConstraints()
    }
    
    private func setupTableView() {
        table.register(ExpensesTableViewCell.self, forCellReuseIdentifier: "ExpensesTableViewCell")
        table.dataSource = self
        table.delegate = self
        table.frame = view.bounds
    }
    
    private func setupConstraints() {
        table.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.bottom.equalToSuperview().inset(10)
        }
    }
}
