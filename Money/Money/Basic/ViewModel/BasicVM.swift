//
//  BasicVM.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.09.2024.
//

import UIKit

protocol MainTransactionViewModelProtocol {
    var count: Int { get }
    var sections: [TableViewSection] { get set }
    var reloadTable: (() -> Void)? { get set }
    
    func getTransaction()
    func clearAll()
    func categorySetupTable()
    func changePlan(_ newPlan: Float, _ category: String)
}

class BasicVM: MainTransactionViewModelProtocol {
    // MARK: - Properties
    var transactions: [TransactionObject] = []
    var count = 0
    var sections: [TableViewSection] = [] {
        didSet {
            reloadTable?()
        }
    }
    var centralSection = TableViewSection(items: [])
    var reloadTable: (() -> Void)?
    
    init() {
        categorySetupTable()
        getTransaction()
    }
    
    func getTransaction() {
        for index in centralSection.items.indices {
            centralSection.items[index].fact = 0
        }

        for transaction in transactions {
            if let index = centralSection.items.firstIndex(where: { $0.category == transaction.category }) {
                let expense = centralSection.items[index]
                centralSection.items[index].fact = (expense.fact ?? 0) + (transaction.fact ?? 0)
            }
        }

        initialSetupTable()
    }
    
    func initialSetupTable() {
        let totalPlan = centralSection.items.reduce(0) { $0 + ($1.plan ?? 0) }
        let totalFact = centralSection.items.reduce(0) { $0 + ($1.fact ?? 0) }
        
        sections = [
            TableViewSection(items: [TransactionObject(category: Constants.Texts.category, date: nil, plan: nil, fact: nil)]),
            centralSection,
            TableViewSection(items: [TransactionObject(category: Constants.Texts.totalCategory, date: nil, plan: totalPlan, fact: totalFact)])
        ]
        
        countTotal()
    }
    
    func changePlan(_ newPlan: Float, _ category: String) {
        UserDefaults.standard.set(newPlan, forKey: category)
        categorySetupTable()
    }
    
    func clearAll() { }
    
    func categorySetupTable() { }
    
    func countTotal() { }
}

// MARK: - UI constants
private extension BasicVM {
    enum Constants {
        enum Texts {
            static let category = "Category".localized
            static let totalCategory = "Total".localized
        }
        enum Sizes {
        }
    }
}
