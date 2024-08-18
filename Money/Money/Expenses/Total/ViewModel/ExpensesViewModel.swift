//
//  ExpensesViewModel.swift
//  Money
//
//  Created by Анастасия Ахановская on 14.08.2024.
//

import UIKit

protocol ExpensesViewModelProtocol {
    var sections: [TableViewSection] { get }
    func addExpenses(_ expenses: ExpensesObject)
}

final class ExpensesViewModel: ExpensesViewModelProtocol {
    private(set) var sections: [TableViewSection] = []
    private var centralSection = TableViewSection(title: nil, items: [])
    
    init() {
        setMocks()
//        getExpense()
        initialSetupTable()
    }
    
    private func getExpense() {

    }
    
    private func initialSetupTable() {
        let totals = centralSection.items.reduce(into: (plan: 0, fact: 0)) { result, item in
            if let plan = item.plan {
                result.plan += plan
            }
            if let fact = item.fact {
                result.fact += fact
            }
        }
        sections = [
            TableViewSection(items: [ExpensesObject(category: "Category", plan: nil, fact: nil)]),
            centralSection,
            TableViewSection(items: [ExpensesObject(category: "Total", plan: totals.plan, fact: totals.fact)])
        ]
    }

    private func setMocks() {
        centralSection = TableViewSection(items:
                                            [ExpensesObject(category: "Transport",
                                                                plan: 2000,
                                                                fact: 0),
                                             ExpensesObject(category: "Beauty",
                                                                plan: 5000,
                                                                fact: 1000)])
    }
    
    func addExpenses(_ expenses: ExpensesObject) {
        // обработай полученые данные из expenses и верни их в контроллер
    }
}
