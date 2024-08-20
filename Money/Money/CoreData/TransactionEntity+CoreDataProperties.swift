//
//  TransactionEntity+CoreDataProperties.swift
//  Money
//
//  Created by Анастасия Ахановская on 20.08.2024.
//
//

import Foundation
import CoreData


extension TransactionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionEntity> {
        return NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    }

    @NSManaged public var category: String?
    @NSManaged public var amount: Float
    @NSManaged public var date: Date?

}

extension TransactionEntity : Identifiable {

}
