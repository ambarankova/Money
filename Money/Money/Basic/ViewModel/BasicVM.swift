//
//  BasicVM.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.09.2024.
//

import UIKit

protocol MainTransactionViewModelProtocol {
    var sections: [TableViewSection] { get set }
    var reloadTable: (() -> Void)? { get set }
    var count: Int { get }
    func getTransaction()
    func changePlan(_ newPlan: Float, _ category: String)
    func clearAll()
}

class BasicVM: MainTransactionViewModelProtocol {
    var reloadTable: (() -> Void)?
    var count = 0
    var sections: [TableViewSection] = [] 
//        didSet {
//            reloadTable?()
//        }
//    }
    var centralSection = TableViewSection(items: [])
    var transactions: [TransactionObject] = []
    
    
    init() {
        categorySetupTable()
        getTransaction()
    }
    
    func getTransaction() {
        sections.removeAll()
//        let transactions = ExpensePersistant.fetchAll()
        
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
    
    func clearAll() {
//        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
//
//        ExpensePersistant.save(expenses)
//        getTransactions()
    }
    
    func changePlan(_ newPlan: Float, _ category: String) {
        UserDefaults.standard.set(newPlan, forKey: category)
    }
    
    func categorySetupTable() {
//        for category in Categories().categories {
//            let plan = UserDefaults.standard.float(forKey: category)
//
//            centralSection.items.append(TransactionObject(category: category, plan: plan, fact: 0, date: nil))
//        }
    }
    
    func countTotal() {

    }
    
    func initialSetupTable() {
        let totalPlan = centralSection.items.reduce(0) { $0 + ($1.plan ?? 0) }
        let totalFact = centralSection.items.reduce(0) { $0 + ($1.fact ?? 0) }
        
        sections = [
            TableViewSection(items: [TransactionObject(category: "Category", plan: nil, fact: nil, date: nil)]),
            centralSection,
            TableViewSection(items: [TransactionObject(category: "Total", plan: totalPlan, fact: totalFact, date: nil)])
        ]
        countTotal()
    }
    
    private func setMocks() {
        centralSection = TableViewSection(items:
                                            [TransactionObject(category: "Transport",
                                                            plan: 2000,
                                                            fact: 2000,
                                                            date: Date()),
                                             TransactionObject(category: "Beauty",
                                                            plan: 5000,
                                                            fact: 1000,
                                                            date: Date())])
    }
}

