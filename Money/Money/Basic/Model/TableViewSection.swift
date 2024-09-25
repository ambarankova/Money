//
//  TableViewSection.swift
//  Money
//
//  Created by Анастасия Ахановская on 15.08.2024.
//

import Foundation

protocol TableViewSectionProtocol {
    var category: String { get }
    var plan: Float? { get set }
    var fact: Float? { get set }
}

struct TableViewSection {
//    var title: String?
    var items: [TableViewSectionProtocol]
}
