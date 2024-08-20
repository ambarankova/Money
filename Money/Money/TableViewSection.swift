//
//  TableViewSection.swift
//  Money
//
//  Created by Анастасия Ахановская on 15.08.2024.
//

import Foundation

protocol TableViewSectionProtocol {
    var plan: Float? { get }
    var fact: Float? { get }
}

struct TableViewSection {
    var title: String?
    var items: [TableViewSectionProtocol]
}
