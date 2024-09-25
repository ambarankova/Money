//
//  IncomeViewModel.swift
//  Money
//
//  Created by Анастасия Ахановская on 23.09.2024.
//

import UIKit

final class IncomeViewModel: BasicVM {
    // MARK: - Properties
    override var transactions: [TransactionObject] {
        get {
            return IncomePersistant.fetchAll()
        }
        set { }
    }
    
    override func categorySetupTable() {
        for category in Categories().categoriesIncome {
            let plan = UserDefaults.standard.float(forKey: category)
            
            centralSection.items.append(TransactionObject(category: category, date: nil, plan: plan, fact: 0))
        }
    }
    
    override func countTotal() {
        count = Int((sections.last?.items[0].fact ?? 0) - (sections.last?.items[0].plan ?? 0))
    }
}

