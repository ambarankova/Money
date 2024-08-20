//
//  ExpensesTableViewCellViewModel.swift
//  Money
//
//  Created by Анастасия Ахановская on 14.08.2024.
//

import Foundation

final class ExpensesTableViewCellViewModel {
    let name: String
    let plan: Float
    let fact: Float
    
    init(expense: ExpensesObject) {
        name = expense.category
        plan = expense.plan ?? 0
        fact = expense.fact ?? 0
    }
}
