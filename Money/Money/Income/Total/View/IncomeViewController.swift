//
//  IncomeViewController.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.08.2024.
//

import SnapKit
import UIKit

final class IncomeViewController: BasicVC {
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 && (indexPath.section + 1) != viewModel?.sections.count {
            guard let category = viewModel?.sections[indexPath.section].items[indexPath.row].category else { return }
            
            let alertController = UIAlertController(title: "Change plan", message: nil, preferredStyle: .alert)
            
            alertController.addTextField { (textField) in
                textField.placeholder = "New plan value"
                textField.keyboardType = .numberPad
            }
            
            let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
                if let newPlanText = alertController.textFields?.first?.text,
                   let newPlan = Float(newPlanText) {
                    self.viewModel?.changePlan(newPlan, category)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
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
