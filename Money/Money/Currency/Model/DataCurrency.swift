//
//  DataCurrency.swift
//  Money
//
//  Created by Анастасия Ахановская on 25.09.2024.
//

import Foundation

struct DataCurrency: Codable {
    let status: Int
    let message: String
    let objects: CurrencyObject
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case objects = "data"
    }
}
