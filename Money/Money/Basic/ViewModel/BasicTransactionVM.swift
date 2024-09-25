//
//  BasicTransactionVM.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.09.2024.
//

import Foundation

protocol TransactionViewModelProtocol {
    var sections: [TableViewSection] { get }
    var reloadTable: (() -> Void)? { get set }
    
    func getTransactions()
    func addExpenses(_ expenses: TransactionObject)
    func addIncome(_ income: TransactionObject)
}

class BasicTransactionVM: TransactionViewModelProtocol {
    private let dateFormatter = DateFormatter()
    private(set) var sections: [TableViewSection] = [] {
        didSet {
            reloadTable?()
        }
    }
    private var lastSection = TableViewSection(items: [])
    var transactions: [TransactionObject] = []
    
    var reloadTable: (() -> Void)?
    
    init() {
        initialSetupTable()
        getTransactions()
    }
    
    func getTransactions() {
        sections.removeAll()
        
        let groupedObjects = transactions.reduce(into: [Date: [TransactionObject]]()) { result, transactions in
            let date = Calendar.current.startOfDay(for: transactions.date ?? Date())
            result[date, default: []].append(transactions)
        }
        
        let keys = groupedObjects.keys
        keys.forEach { key in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            sections.append(TableViewSection(items: groupedObjects[key] ?? []))
        }
    }
    
    func addExpenses(_ expenses: TransactionObject) { }
    
    func addIncome(_ income: TransactionObject) { }
    
    private func initialSetupTable() {
        sections = [
            TableViewSection(items: [TransactionObject(category: Constants.Texts.category, date: nil, plan: nil, fact: nil)])
        ]
    }
}

// MARK: - UI constants
private extension BasicTransactionVM {
    enum Constants {
        enum Texts {
            static let category = "Category"
        }
        enum Sizes {
        }
    }
}
