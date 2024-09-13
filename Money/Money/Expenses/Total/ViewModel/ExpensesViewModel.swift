//
//  ExpensesViewModel.swift
//  Money
//
//  Created by Анастасия Ахановская on 14.08.2024.
//

import UIKit

protocol ExpensesViewModelProtocol {
    var sections: [TableViewSection] { get }
    var reloadTable: (() -> Void)? { get set }
    var count: Int { get }
    var centralSection: TableViewSection { get }
    func getExpense()
    func addExpenses(_ expenses: ExpensesObject)
    func changePlan(_ expenses: ExpensesObject)
}

final class ExpensesViewModel: ExpensesViewModelProtocol {
    var reloadTable: (() -> Void)?
    private(set) var sections: [TableViewSection] = [] {
        didSet {
            reloadTable?()
        }
    }
    var centralSection = TableViewSection(title: nil, items: [])
    var count = 0
    
    init() {
        getExpense()
    }
    
    func getExpense() {
        categorySetupTable()
        let transactions = TransactionPersistant.fetchAll()
        sections = []
        
        for transaction in transactions {
            if let index = centralSection.items.firstIndex(where: { $0.category == transaction.category }) {
                let expense = centralSection.items[index]
                guard var fact = expense.fact else { return }
                fact += transaction.fact ?? 0
//                guard var plan = expense.plan else { return }
//                plan += transaction.plan ?? 0
//                centralSection.items[index].plan = plan
            }
        }
        initialSetupTable()
    }
    
    func addExpenses(_ expenses: ExpensesObject) {
        if let index = centralSection.items.firstIndex(where: { $0.category == expenses.category }) {
            let expense = centralSection.items[index]
            guard var fact = expense.fact else { return }
            fact += expenses.fact ?? 0
            centralSection.items[index].fact = fact
        }
    }
    
    func changePlan(_ expenses: ExpensesObject) {
//        var transactions = TransactionPersistant.fetchAll()
        
//        transactions.forEach { transaction in
//            if transaction.category == expenses.category {
//                for i in 0..<transactions.count {
//                    transactions[i].plan = 2000
//                }
//                transaction.plan = expenses.plan
//            }
//        }
//        TransactionPersistant.saveContext()
//        print(TransactionPersistant.fetchAll())
//        TransactionPersistant.save(expenses)
//        getExpense()
    }
    
    private func categorySetupTable() {
        for category in Categories().categories {
            centralSection.items.append(ExpensesObject(category: category, plan: 0, fact: 0, date: Date()))
        }
    }
    
    private func initialSetupTable() {
        let totalPlan = centralSection.items.reduce(0) { $0 + ($1.plan ?? 0) }
        let totalFact = centralSection.items.reduce(0) { $0 + ($1.fact ?? 0) }
        
        sections = [
            TableViewSection(items: [ExpensesObject(category: "Category", plan: nil, fact: nil, date: Date())]),
            centralSection,
            TableViewSection(items: [ExpensesObject(category: "Total", plan: totalPlan, fact: totalFact, date: Date())])
        ]
        
        count = Int(totalPlan - totalFact)
    }
    
    private func setMocks() {
        centralSection = TableViewSection(items:
                                            [ExpensesObject(category: "Transport",
                                                            plan: 2000,
                                                            fact: 2000,
                                                            date: Date()),
                                             ExpensesObject(category: "Beauty",
                                                            plan: 5000,
                                                            fact: 1000,
                                                            date: Date())])
    }
}
