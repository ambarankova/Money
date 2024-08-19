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
    var reloadTable: (() -> Void)? { get set }
}

final class ExpTransactionViewModel: ExpTransactionViewModelProtocol {
    var reloadTable: (() -> Void)?
    
    private let dateFormatter = DateFormatter()
    private(set) var sections: [TableViewSection] = [] {
        didSet {
            reloadTable?()
        }
    }
    private var lastSection = TableViewSection(title: nil, items: [])
    
    init() {
        initialSetupTable()
    }
    
    func addExpenses(_ expenses: ExpensesObject) {
        lastSection = TableViewSection(items:
                                        [ExpensesObject(category: expenses.category,
                                                        plan: expenses.plan,
                                                        fact: expenses.fact,
                                                        date: expenses.date)])
        sections.append(lastSection)
    }
    
    
    private func initialSetupTable() {
        sections = [
            TableViewSection(items: [ExpensesObject(category: "Category", plan: nil, fact: nil, date: nil)])
        ]
    }
}

