//
//  ExpensesObject.swift
//  Money
//
//  Created by Анастасия Ахановская on 14.08.2024.
//

import Foundation

struct TransactionObject: TableViewSectionProtocol {
    let category: String
    var plan: Float?
    var fact: Float?
    let date: Date?
}
