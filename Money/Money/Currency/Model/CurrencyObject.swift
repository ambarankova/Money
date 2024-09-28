//
//  Currency.swift
//  Money
//
//  Created by Анастасия Ахановская on 25.09.2024.
//

import Foundation

struct CurrencyObject: Codable {
    let conversionRates: Rate
}

struct Rate: Codable {
    let EUR: Double
    let USD: Double
}
