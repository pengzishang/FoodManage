//
//  DataManger.swift
//  FoodManage
//
//  Created by DeshPeng on 2018/10/30.
//  Copyright © 2018 pzs. All rights reserved.
//

import UIKit
import CoreData
import SwiftDate

class DataManger: NSObject {

    static let share = DataManger()

    static let DataMangerDidSaveData = Notification.Name(rawValue: "DataMangerDidSaveData")
    
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

    var currentInputName: String?
    var currentSuggestName: String?
    var currentImage: UIImage?
    
    var currentModel: FoodDateModel?

    // 更新数据
    private func saveContext() -> Bool{
        do {
            try context.save()
            NotificationCenter.default.post(name: DataManger.DataMangerDidSaveData, object: self.currentModel, userInfo: nil)
            return true
        } catch {
//            let nserror = error as NSError
            return false
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }

    func deleteWith(importDate: Date) -> Bool{
        let fetchRequest: NSFetchRequest = FoodDateModel.fetchRequest()
        let predicate = NSPredicate(format: "importDate == %@",importDate as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try context.fetch(fetchRequest)
            for data in result {
                context.delete(data)
            }
        } catch {
//            fatalError()
            return false
        }
        return saveContext()
    }

    public func insertFood() -> Bool {
         return saveContext()
    }

    public func setupNew()  {
        self.currentModel = NSEntityDescription.insertNewObject(forEntityName: "FoodDateModel", into: context) as? FoodDateModel
    }
    
    public func fetchAll() -> [FoodDateModel] {
        let fetchRequest: NSFetchRequest = FoodDateModel.fetchRequest()
        do {
            var result = try context.fetch(fetchRequest)
            result.sort {
                if let date2 = $1.expireDate , let date1 = $0.expireDate {
                    return date1 <= date2 + 1.seconds
                } else {
                    return true
                }
            }
            return result
        } catch {
            fatalError()
        }
    }

}
