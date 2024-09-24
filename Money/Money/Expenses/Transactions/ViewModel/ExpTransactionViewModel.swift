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
    
    override func addExpenses(_ expenses: TransactionObject) {
        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
        
        ExpensePersistant.save(expenses)
        getTransactions()
    }
}
