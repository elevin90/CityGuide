//
//  CoreDataStack.swift
//  WeatherLocation
//
//  Created by Evgeniy Levin on 8/9/19.
//  Copyright © 2019 Evgeniy Levin. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    private let modelName: String
    
    private init(modelName: String) {
        self.modelName = modelName
        
    }
    
    private lazy var storageURL: URL? = {
        let path = "\(modelName).sqlite"
        var documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentDirectory?.appendingPathComponent(path)
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Database file not found")
        }
        guard let managedModel =  NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error in DB deserialization")
        }
        return  managedModel
    }()
    
    private lazy var storeCoordinator : NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
            let coordinatorOptions = [
                NSInferMappingModelAutomaticallyOption : true,
                NSMigratePersistentStoresAutomaticallyOption : true
            ]
            
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                               configurationName: nil,
                                               at: self.storageURL, options: coordinatorOptions)
            
        } catch {
            print(error)
        }
       return coordinator
    }()
    
    private lazy var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = self.backgroundContext
        return context
    }()
    
    private lazy var backgroundContext: NSManagedObjectContext = {
       let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = self.storeCoordinator
        return context
    }()
    
    private func setupNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(onNotification), name: Notification.Name.NSExtensionHostDidEnterBackground, object: nil)
    }
    
    @objc private func onNotification(notification: NSNotification) {
        
    }
    
    public func save(_ object: NSManagedObject) {
        mainContext.perform {[weak self] in
            guard let welf = self else { return }
            if welf.mainContext.hasChanges {
                do { try welf.mainContext.save() }
                catch { print(error as NSError)  }
            }
            
            if welf.backgroundContext.hasChanges {
                do { try welf.backgroundContext.save() }
                catch { print(error as NSError) }
            }
        }
    }
    
}
