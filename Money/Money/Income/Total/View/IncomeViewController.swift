//
//  IncomeViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import SnapKit
import UIKit

final class IncomeViewController: BasicVC {
    // MARK: - Methods
    @objc override func clearButtonTapped() {
        viewModel?.clearAll()
        viewModel?.getTransaction()
        viewModel?.reloadTable?()
    }
}

extension IncomeViewController: IncTransactionViewControllerDelegate {
    func transactionAdded() {
        viewModel?.getTransaction()
        viewModel?.reloadTable?()
    }
}
