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
    func getTransactions()
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
        // Забыла вызывать загрузку транзакций 
        getTransactions()
    }
    
    func getTransactions() {
        sections.removeAll()
        let transactions = TransactionPersistant.fetchAll()
        
        let groupedObjects = transactions.reduce(into: [Date: [ExpensesObject]]()) { result, transactions in
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

    func addExpenses(_ expenses: ExpensesObject) {
        TransactionPersistant.save(expenses)
        getTransactions()
    }
    
    
    private func initialSetupTable() {
        sections = [
            TableViewSection(items: [ExpensesObject(category: "Category", plan: nil, fact: nil, date: nil)])
        ]
    }
}

