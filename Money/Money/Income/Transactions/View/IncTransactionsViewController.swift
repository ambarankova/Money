//
//  IncTransactionsViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 23.09.2024.
//

import SnapKit
import UIKit

protocol IncTransactionViewControllerDelegate: AnyObject {
    func transactionAdded()
}

final class IncTransactionsViewController: BasicTransactionVC {
    // MARK: - Properties
    weak var delegate: IncTransactionViewControllerDelegate?
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let transaction = viewModel?.sections[indexPath.section].items[indexPath.row] as? TransactionObject else { return nil}
        let deleteAction = UIContextualAction(style: .normal, title: "Delete".localized) { (action, view, success) in
            IncomePersistant.delete(transaction)
            self.delegate?.transactionAdded()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
// MARK: - Private
extension IncTransactionsViewController {
    @objc override func addButtonTapped() {
        let addIncomeVC = AddIncomeViewController()
        addIncomeVC.delegate = self
        present(addIncomeVC, animated: true, completion: nil)
    }
}

// MARK: - AddExpensesViewControllerDelegate
extension IncTransactionsViewController: AddIncomeViewControllerDelegate {
    func didAddIncome(_ income: TransactionObject) {
        viewModel?.addIncome(income)
        delegate?.transactionAdded()
    }
}
