//
//  IncomeViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import SnapKit
import UIKit

final class IncomeViewController: BasicVC {
    // MARK: - UITableViewDataSourse
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.sections[section].items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTransactionTableViewCell.reuseID,
                                                       for: indexPath) as? MainTransactionTableViewCell else {
            return UITableViewCell()
        }
        if let income = viewModel?.sections[indexPath.section].items[indexPath.row]
            as? TransactionObject {
            cell.configure(with: income)
        }
        return cell
    }
}
