//
//  IncomeEntity+CoreDataProperties.swift
//  Money
//
//  Created by Анастасия Ахановская on 23.09.2024.
//
//

import Foundation
import CoreData


extension IncomeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IncomeEntity> {
        return NSFetchRequest<IncomeEntity>(entityName: "IncomeEntity")
    }

    @NSManaged public var amount: Float
    @NSManaged public var category: String?
    @NSManaged public var date: Date?

}

extension IncomeEntity : Identifiable {

}
