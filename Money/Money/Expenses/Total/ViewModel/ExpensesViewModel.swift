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
    func getExpense()
    func changePlan(_ newPlan: Float, _ category: String)
}

final class ExpensesViewModel: ExpensesViewModelProtocol {
    var reloadTable: (() -> Void)?
    var count = 0
    private(set) var sections: [TableViewSection] = [] {
        didSet {
            reloadTable?()
        }
    }
    private var centralSection = TableViewSection(title: nil, items: [])
    
    init() {
        categorySetupTable()
        getExpense()
    }
    
    func getExpense() {
        sections.removeAll()
        let transactions = TransactionPersistant.fetchAll()
        
        for transaction in transactions {
            if let index = centralSection.items.firstIndex(where: { $0.category == transaction.category }) {
                let expense = centralSection.items[index]
                guard var fact = expense.fact else { return }
                fact += transaction.fact ?? 0
                centralSection.items[index].fact = fact
            }
        }
        initialSetupTable()
    }
    
    func changePlan(_ newPlan: Float, _ category: String) {
        UserDefaults.standard.set(newPlan, forKey: category)
    }
    
    private func categorySetupTable() {
        for category in Categories().categories {
            let plan = UserDefaults.standard.float(forKey: category)
            
            centralSection.items.append(ExpensesObject(category: category, plan: plan, fact: 0, date: nil))
        }
    }
    
    private func initialSetupTable() {
        let totalPlan = centralSection.items.reduce(0) { $0 + ($1.plan ?? 0) }
        let totalFact = centralSection.items.reduce(0) { $0 + ($1.fact ?? 0) }
        
        sections = [
            TableViewSection(items: [ExpensesObject(category: "Category", plan: nil, fact: nil, date: nil)]),
            centralSection,
            TableViewSection(items: [ExpensesObject(category: "Total", plan: totalPlan, fact: totalFact, date: nil)])
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
