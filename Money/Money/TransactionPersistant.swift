//
//  TransactionPersistant.swift
//  Money
//
//  Created by Анастасия Ахановская on 20.08.2024.
//

import CoreData
import Foundation

final class TransactionPersistant {
    private static let context = AppDelegate.persistantContainer.viewContext
    
    static func save(_ transaction: ExpensesObject) {
        var entity: TransactionEntity?
        
        if let ent = getEntity(for: transaction) {
            entity = ent
        } else {
            guard let description = NSEntityDescription.entity(forEntityName: "TransactionEntity",
                                                               in: context) else { return }
            entity = TransactionEntity(entity: description,
                                    insertInto: context)
        }
        
        entity?.category = transaction.category
        entity?.amount = transaction.fact ?? 0
        entity?.date = transaction.date

        saveContext()
    }
    
    static func delete(_ transaction: ExpensesObject) {
        guard let entity = getEntity(for: transaction) else { return }
        context.delete(entity)
        saveContext()
    }
    
    static func fetchAll() -> [ExpensesObject] {
        let request = TransactionEntity.fetchRequest()
        
        do {
            let objects = try context.fetch(request)
            return convert(entities: objects)
        } catch let error {
            debugPrint("Fetch notes error: \(error)")
            return []
        }
    }
    
    // MARK: - Private Methods
    private static func convert(entities: [TransactionEntity]) -> [ExpensesObject] {
        let transactions = entities.map {
            ExpensesObject(category: $0.category ?? "",
                           plan: nil,
                           fact: $0.amount,
                           date: $0.date ?? Date())
        }
        return transactions
    }
    
    private static func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
    }
    
    private static func getEntity(for transaction: ExpensesObject) -> TransactionEntity? {
        let request = TransactionEntity.fetchRequest()
    
        do {
            let objects = try context.fetch(request)
            return objects.first
        } catch let error {
            debugPrint("Fetch notes error: \(error)")
            return nil
        }
    }
    
    private static func saveContext() {
        do {
            try context.save()
            postNotification()
        } catch let error {
            debugPrint("Save note error: \(error)")
        }
    }
}
