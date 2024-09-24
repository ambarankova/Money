//
//  IncTransactionsViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 23.09.2024.
//

import SnapKit
import UIKit

final class IncTransactionsViewController: BasicTransactionVC { }
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
    }
}
