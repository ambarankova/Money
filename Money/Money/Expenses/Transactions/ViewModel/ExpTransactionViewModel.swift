//
//  ExpTransactionViewModel.swift
//  Money
//
//  Created by Анастасия Ахановская on 15.08.2024.
//

import Foundation

final class ExpTransactionViewModel: BasicTransactionVM {
    // MARK: - Properties
    override var transactions: [TransactionObject] {
        get {
            return ExpensePersistant.fetchAll()
        }
        set { }
    }
    
    // MARK: - Methods
    override func addExpenses(_ expenses: TransactionObject) {
        ExpensePersistant.save(expenses)
        getTransactions()
    }
}
