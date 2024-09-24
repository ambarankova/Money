//
//  ExpTransactionViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 15.08.2024.
//

import SnapKit
import UIKit

final class ExpTransactionViewController: BasicTransactionVC {
    
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
    }
}
