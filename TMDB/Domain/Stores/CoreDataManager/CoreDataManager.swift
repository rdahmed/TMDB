//
//  CoreDataManager.swift
//  TMDB
//
//  Created by Radwa Ahmed on 14/09/2023.
//

import Foundation
import CoreData

// MARK: - CoreData Protocols

protocol CoreDataRetrivable {
    init(managedObject: NSManagedObject)
}

protocol CoreDataStorable {
    @discardableResult
    func mapToManagedObject(entity: NSEntityDescription, insertInto: NSManagedObjectContext) -> NSManagedObject
}

typealias CoreDataModel = CoreDataStorable & CoreDataRetrivable

// MARK: - Database

protocol Database {
    func fetch<T: CoreDataRetrivable>(table: CoreDataTables, predicate: NSPredicate?) -> [T]
    func store<T: CoreDataStorable>(object: T, in table: CoreDataTables)
    func delete(table: CoreDataTables, predicate: NSPredicate?)
    func update(table: CoreDataTables, values: [String: Any], predicate: NSPredicate?)
}

class CoreDataDatabase: Database {
    
    private let context: NSManagedObjectContext = AppDelegate.shared.managedObjectContext
    
    func fetch<T: CoreDataRetrivable>(table: CoreDataTables, predicate: NSPredicate? = nil) -> [T] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: table.rawValue)
        do {
            if let predicate = predicate { fetchRequest.predicate = predicate }
            let items = try context.fetch(fetchRequest)
            var list: [T] = []
            for item in items {
                list.append(T(managedObject: item))
            }
            return list
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return [T]()
    }
    
    func store<T: CoreDataStorable>(object: T, in table: CoreDataTables) {
        guard let entity = NSEntityDescription.entity(forEntityName: table.rawValue, in: context) else { return }
        object.mapToManagedObject(entity: entity, insertInto: context)
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not store. \(error), \(error.userInfo)")
        }
    }
    
    func delete(table: CoreDataTables, predicate: NSPredicate? = nil) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: table.rawValue)
        fetchRequest.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    func update(table: CoreDataTables, values: [String: Any], predicate: NSPredicate?) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: table.rawValue)
        do {
            if let predicate = predicate { fetchRequest.predicate = predicate }
            let items = try context.fetch(fetchRequest)
            for item in items {
                for value in values {
                    item.setValue(value.value, forKey: value.key)
                }
            }
            try context.save()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
