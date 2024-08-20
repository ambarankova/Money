//
//  ExpensesViewModel.swift
//  Money
//
//  Created by Анастасия Ахановская on 14.08.2024.
//

import UIKit

protocol ExpensesViewModelProtocol {
    var sections: [TableViewSection] { get }
}

final class ExpensesViewModel: ExpensesViewModelProtocol {
    private(set) var sections: [TableViewSection] = []
    private var centralSection = TableViewSection(title: nil, items: [])
    
    init() {
//        setMocks()
        getExpense()
        initialSetupTable()
    }
    
    private func getExpense() {

    }
    
    private func initialSetupTable() {
        let totals = centralSection.items.reduce(into: (plan: 0, fact: 0)) { result, item in
            if let plan = item.plan {
                result.plan += Int(plan)
            }
            if let fact = item.fact {
                result.fact += Int(fact)
            }
        }
        
        sections = [
            TableViewSection(items: [ExpensesObject(category: "Category", plan: nil, fact: nil, date: nil)]),
            centralSection,
            TableViewSection(items: [ExpensesObject(category: "Total", plan: Float(totals.plan), fact: Float(totals.fact), date: nil)])
        ]
    }

//    private func setMocks() {
//        centralSection = TableViewSection(items:
//                                            [ExpensesObject(category: "Transport",
//                                                                plan: 2000,
//                                                                fact: 2000,
//                                                                date: "01 jan 2001"),
//                                             ExpensesObject(category: "Beauty",
//                                                                plan: 5000,
//                                                                fact: 1000,
//                                                                date: "02 jan 2001")])
//    }
}
