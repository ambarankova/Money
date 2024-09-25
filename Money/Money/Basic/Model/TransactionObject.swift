//
//  TransactionObject.swift
//  Money
//
//  Created by Анастасия Ахановская on 14.08.2024.
//

import Foundation

struct TransactionObject: TableViewSectionProtocol {
    let category: String
    let date: Date?
    var plan: Float?
    var fact: Float?
}
