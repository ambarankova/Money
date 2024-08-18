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
        setupTable()
    }
    
    private func getExpense() {
        
    }
    
    private func setupTable() {
        var totalPlan = 0
        var totalFact = 0
        
        centralSection.items.forEach {
            guard let plan = $0.plan else { return }
            totalPlan += plan
        }
        
        centralSection.items.forEach {
            guard let fact = $0.fact else { return }
            totalFact += fact
        }
        
        let section: [TableViewSection] = [TableViewSection(items:
                                                                [ExpensesObject(name: "Category",
                                                                                plan: nil,
                                                                                fact: nil)]),
                                           centralSection,
                                           TableViewSection(items:
                                                                [ExpensesObject(name: "Total",
                                                                                plan: totalPlan,
                                                                                fact: totalFact)])]
        self.sections = section
    }
    
    private func setMocks() {
        centralSection = TableViewSection(items:
                                                [ExpensesObject(name: "Transport",
                                                                plan: 2000,
                                                                fact: 0),
                                                 ExpensesObject(name: "Beauty",
                                                                plan: 5000,
                                                                fact: 1000)])
    }
}
