//
//  ExpensesViewModel.swift
//  Money
//
//  Created by Анастасия Ахановская on 14.08.2024.
//

import UIKit

final class ExpensesViewModel: BasicVM {
    // MARK: - Properties
    override var transactions: [TransactionObject] {
        get {
            return ExpensePersistant.fetchAll()
        }
        set { }
    }
    
    // MARK: - Methods
    override func clearAll() {
        ExpensePersistant.clearCoreData()
    }
    
    override func categorySetupTable() {
        centralSection.items.removeAll()

        for category in Categories().categoriesExpense {
            let plan = UserDefaults.standard.float(forKey: category)
            
            centralSection.items.append(TransactionObject(category: category, date: nil, plan: plan, fact: 0))
        }
        getTransaction()
        reloadTable?()
    }
    
    override func countTotal() {
        count = Int((sections.last?.items[0].plan ?? 0) - (sections.last?.items[0].fact ?? 0))
    }
}
