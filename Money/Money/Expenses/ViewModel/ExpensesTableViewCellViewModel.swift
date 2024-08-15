//
//  ExpensesTableViewCellViewModel.swift
//  Money
//
//  Created by Анастасия Ахановская on 14.08.2024.
//

import Foundation

final class ExpensesTableViewCellViewModel {
    let name: String
    let plan: Int
    let fact: Int
    
    init(expense: ExpensesObject) {
        name = expense.category
        plan = expense.plan ?? 0
        fact = expense.fact ?? 0
    }
}
