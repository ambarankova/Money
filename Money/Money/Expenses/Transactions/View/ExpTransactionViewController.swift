//
//  ExpTransactionViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 15.08.2024.
//

import SnapKit
import UIKit

protocol ExpTransactionViewControllerDelegate: AnyObject {
    func transactionWasAdded()
}

final class ExpTransactionViewController: BasicTransactionVC {
    // MARK: - Properties
    weak var delegate: ExpTransactionViewControllerDelegate?
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let transaction = viewModel?.sections[indexPath.section].items[indexPath.row] as? TransactionObject else { return nil}
        let deleteAction = UIContextualAction(style: .normal, title: "Delete".localized) { (action, view, success) in
            ExpensePersistant.delete(transaction)
            self.delegate?.transactionWasAdded()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - Private
extension ExpTransactionViewController {
    @objc override func addButtonTapped() {
        let addExpenseVC = AddExpensesViewController()
        addExpenseVC.delegate = self
        present(addExpenseVC, animated: true, completion: nil)
    }
}

// MARK: - AddExpensesViewControllerDelegate
extension ExpTransactionViewController: AddExpensesViewControllerDelegate {
    func didAddExpense(_ expense: TransactionObject) {
        viewModel?.addExpenses(expense)
        delegate?.transactionWasAdded()
    }
}
