//
//  DataManger.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/10/30.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import CoreData

class DataManger: NSObject {

    static let share = DataManger()

    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "FoodDataModel", withExtension: "momd")
        let managedObjectModel = NSManagedObjectModel.init(contentsOf: modelURL!)
        return managedObjectModel!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator.init(managedObjectModel: managedObjectModel)
        let sqliteURL = documentDir.appendingPathComponent("FoodDataModel.sqlite")
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        var failureReason = "There was an error creating or loading the application's saved data."

        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: sqliteURL, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: Any]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as Any?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as Any?
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 6666, userInfo: dict)
            print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return persistentStoreCoordinator
    }()

    lazy var documentDir: URL = {
        let documentDir = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        return documentDir!
    }()

    lazy var context: NSManagedObjectContext = {
        let context = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()

    // 更新数据
    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }

    func deleteWith(importDate: TimeInterval) {
        let fetchRequest: NSFetchRequest = FoodDateModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "importDate == %@", importDate)
        do {
            let result = try context.fetch(fetchRequest)
            for data in result {
                context.delete(data)
            }
        } catch {
            fatalError()
        }
        saveContext()
    }

    public func insertFood(_ data: FoodDateModel) {
        saveContext()
    }

    public func fetchAll() -> [FoodDateModel] {
        let fetchRequest: NSFetchRequest = FoodDateModel.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            fatalError()
        }
    }

}

extension FoodDateModel {
    func importData(with data: FoodDateModel) {
        self.duration = data.duration
        self.imageURL = data.imageURL
        self.importDate = data.importDate
        self.inputName = data.inputName
        self.isExpired = data.isExpired
        self.position = data.position
        self.suggestName = data.suggestName
    }
}
