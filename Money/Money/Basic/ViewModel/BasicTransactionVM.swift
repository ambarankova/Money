//
//  BasicTransactionVM.swift
//  Money
//
//  Created by Анастасия Ахановская on 13.09.2024.
//

import Foundation

protocol TransactionViewModelProtocol {
    var sections: [TableViewSection] { get }
    func addExpenses(_ expenses: TransactionObject)
    func addIncome(_ income: TransactionObject)
    func getTransactions()
    var reloadTable: (() -> Void)? { get set }
}

class BasicTransactionVM: TransactionViewModelProtocol {
    var reloadTable: (() -> Void)?
    
    private let dateFormatter = DateFormatter()
    private(set) var sections: [TableViewSection] = [] {
        didSet {
            reloadTable?()
        }
    }
    private var lastSection = TableViewSection(items: [])
    var transactions: [TransactionObject] = []
    
    init() {
        initialSetupTable()
        getTransactions()
    }
    
    func getTransactions() {
        sections.removeAll()
//        let transactions = ExpensePersistant.fetchAll()
        
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

    func addExpenses(_ expenses: TransactionObject) {
//        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
//        
//        ExpensePersistant.save(expenses)
//        getTransactions()
    }
    
    func addIncome(_ income: TransactionObject) {
//        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
//
//        IncomePersistant.save(income)
//        getTransactions()
    }
    
    private func initialSetupTable() {
        sections = [
            TableViewSection(items: [TransactionObject(category: "Category", plan: nil, fact: nil, date: nil)])
        ]
    }
}


