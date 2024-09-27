//
//  ExpensesViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import SnapKit
import UIKit

final class ExpensesViewController: BasicVC {
    // MARK: - Methods
    @objc override func clearButtonTapped() {
        viewModel?.clearAll()
        viewModel?.getTransaction()
        viewModel?.reloadTable?()
    }
}

extension ExpensesViewController: ExpTransactionViewControllerDelegate {
    func transactionWasAdded() {
        viewModel?.getTransaction()
        viewModel?.reloadTable?()
    }
}
