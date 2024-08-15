//
//  TableViewSection.swift
//  Money
//
//  Created by Анастасия Ахановская on 15.08.2024.
//

import Foundation

protocol TableViewSectionProtocol {
    var plan: Int? { get }
    var fact: Int? { get }
}

struct TableViewSection {
    var title: String?
    var items: [TableViewSectionProtocol]
}
