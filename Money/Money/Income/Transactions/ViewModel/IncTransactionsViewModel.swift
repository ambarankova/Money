//
//  IncTransactionsViewModel.swift
//  Money
//
//  Created by Анастасия Ахановская on 23.09.2024.
//

import Foundation

final class IncTransactionsViewModel: BasicTransactionVM {
    // MARK: - Properties
    override var transactions: [TransactionObject] {
        get {
            return IncomePersistant.fetchAll()
        }
        set { }
    }
    
    // MARK: - Methods
    override func addIncome(_ income: TransactionObject) {
        IncomePersistant.save(income)
        getTransactions()
    }
}
