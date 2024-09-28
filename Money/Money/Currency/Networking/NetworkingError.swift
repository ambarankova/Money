//
//  NetworkingError.swift
//  Money
//
//  Created by Анастасия Ахановская on 25.09.2024.
//

import Foundation

enum NetworkingError: Error {
    case networkingError(_ code: Error)
    case unknown
}
