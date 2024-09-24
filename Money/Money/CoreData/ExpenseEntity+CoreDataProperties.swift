//
//  ExpenseEntity+CoreDataProperties.swift
//  Money
//
//  Created by Анастасия Ахановская on 20.08.2024.
//
//

import Foundation
import CoreData


extension ExpenseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseEntity> {
        return NSFetchRequest<ExpenseEntity>(entityName: "ExpenseEntity")
    }

    @NSManaged public var category: String?
    @NSManaged public var amount: Float
    @NSManaged public var date: Date?

}

extension ExpenseEntity : Identifiable {

}
