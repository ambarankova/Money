//
//  ExpensesObject.swift
//  Money
//
//  Created by Анастасия Ахановская on 14.08.2024.
//

import Foundation

struct ExpensesObject: TableViewSectionProtocol {
    let category: String
    let plan: Int?
    let fact: Int?
}
