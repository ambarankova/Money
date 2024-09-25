//
//  Currency.swift
//  Money
//
//  Created by Анастасия Ахановская on 25.09.2024.
//

import Foundation

struct CurrencyObject: Codable {
    let USDRUB: String
    let EURRUB: String
    
    enum CodingKeys: CodingKey {
        case USDRUB
        case EURRUB
    }
}
