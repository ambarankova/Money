//
//  ExpTransactionViewModel.swift
//  Money
//
//  Created by Анастасия Ахановская on 15.08.2024.
//

import Foundation

protocol ExpTransactionViewModelProtocol {
    var sections: [TableViewSection] { get }
    func addExpenses(_ expenses: ExpensesObject)
}

final class ExpTransactionViewModel: ExpTransactionViewModelProtocol {
    private(set) var sections: [TableViewSection] = []
    private var lastSection = TableViewSection(title: nil, items: [])
    
    init(transaction: ExpensesObject?) {
        initialSetupTable()
    }
    
    func addExpenses(_ expenses: ExpensesObject) {
        lastSection = TableViewSection(items:
                                            [ExpensesObject(category: expenses.category,
                                                            plan: expenses.plan,
                                                            fact: expenses.fact,
                                                            date: expenses.date)])
    }
    
    
    private func initialSetupTable() {
        sections = [
            TableViewSection(items: [ExpensesObject(category: "Category", plan: nil, fact: nil, date: nil)]),
            lastSection
        ]
    }
}

