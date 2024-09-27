//
//  ExpensePersistant.swift
//  Money
//
//  Created by Анастасия Ахановская on 20.08.2024.
//

import CoreData
import Foundation
import UIKit

final class ExpensePersistant {
    private static let context = AppDelegate.persistantContainer.viewContext
    
    static func save(_ transaction: TransactionObject) {
        var entity: ExpenseEntity?
        
        if let ent = getEntity(for: transaction) {
            entity = ent
        } else {
            guard let description = NSEntityDescription.entity(forEntityName: "ExpenseEntity",
                                                               in: context) else { return }
            entity = ExpenseEntity(entity: description,
                                   insertInto: context)
        }
        
        entity?.category = transaction.category
        entity?.amount = transaction.fact ?? 0
        entity?.date = transaction.date
        
        saveContext()
    }
    
    static func delete(_ transaction: TransactionObject) {
        guard let entity = getEntity(for: transaction) else { return }
        context.delete(entity)
        saveContext()
    }
    
    static func fetchAll() -> [TransactionObject] {
        let request = ExpenseEntity.fetchRequest()
        
        do {
            let objects = try context.fetch(request)
            return convert(entities: objects)
        } catch let error {
            debugPrint("Fetch transactions error: \(error)")
            return []
        }
    }
    
    // MARK: - Private Methods
    private static func convert(entities: [ExpenseEntity]) -> [TransactionObject] {
        let transactions = entities.map {
            TransactionObject(category: $0.category ?? "",
                              date: $0.date ?? Date(), plan: nil,
                              fact: $0.amount)
        }
        return transactions
    }
    
    private static func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
    }
    
    private static func getEntity(for transaction: TransactionObject) -> ExpenseEntity? {
        let request = ExpenseEntity.fetchRequest()
        request.predicate = NSPredicate(format: "category == %@ AND date == %@", transaction.category, transaction.date as? NSDate ?? NSDate())
        
        do {
            let objects = try context.fetch(request)
            return objects.first
        } catch let error {
            debugPrint("Fetch transaction error: \(error)")
            return nil
        }
    }
    
    private static func saveContext() {
        do {
            try context.save()
            postNotification()
        } catch let error {
            debugPrint("Save transaction error: \(error)")
        }
    }
    
    static func clearCoreData() {
        let entityNames = AppDelegate.persistantContainer.managedObjectModel.entities.map({ $0.name! })
        
        for entityName in entityNames {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(batchDeleteRequest)
            } catch let error {
                print("Deleting transactions error: \(error)")
            }
        }
        saveContext()
    }
}
