//
//  ExpTransactionViewModel.swift
//  Money
//
//  Created by Анастасия Ахановская on 15.08.2024.
//

import Foundation

final class ExpTransactionViewModel: ExpensesViewModelProtocol {
    func addExpenses(_ expenses: ExpensesObject) {
        print(expenses)
    }
    
    var sections: [TableViewSection] = []
    
    init() {

    }
}
