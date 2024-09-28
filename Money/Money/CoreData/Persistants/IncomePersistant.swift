//
//  IncomePersistant.swift
//  Money
//
//  Created by Анастасия Ахановская on 23.09.2024.
//

import CoreData
import Foundation

final class IncomePersistant {
    private static let context = AppDelegate.persistantContainer.viewContext
    
    static func save(_ transaction: TransactionObject) {
        var entity: IncomeEntity?
        
        if let ent = getEntity(for: transaction) {
            entity = ent
        } else {
            guard let description = NSEntityDescription.entity(forEntityName: "IncomeEntity",
                                                               in: context) else { return }
            entity = IncomeEntity(entity: description,
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
        let request = IncomeEntity.fetchRequest()
        
        do {
            let objects = try context.fetch(request)
            return convert(entities: objects)
        } catch let error {
            debugPrint("Fetch notes error: \(error)")
            return []
        }
    }
    
    // MARK: - Private Methods
    private static func convert(entities: [IncomeEntity]) -> [TransactionObject] {
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
    
    private static func getEntity(for transaction: TransactionObject) -> IncomeEntity? {
        let request = IncomeEntity.fetchRequest()
        request.predicate = NSPredicate(format: "category == %@ AND date == %@", transaction.category, transaction.date as? NSDate ?? NSDate())
    
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

