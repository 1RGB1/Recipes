//
//  CoreDataManager.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import CoreData
import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        // THIS NAME MUST MATCH YOUR .xcdatamodeld FILE NAME EXACTLY
        let container = NSPersistentContainer(name: "RecipeCache")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("❌ Core Data error: \(error)")
                print("Store Description: \(storeDescription)")
                
                // For development: delete and recreate store
                if let storeURL = storeDescription.url {
                    try? FileManager.default.removeItem(at: storeURL)
                    print("🗑️ Deleted corrupted store, will recreate")
                }
            } else {
                print("✅ Core Data store loaded successfully")
                print("Store URL: \(storeDescription.url?.absoluteString ?? "Unknown")")
            }
        }
        
        // Configure context for better performance
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func save() {
        let context = persistentContainer.viewContext
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            print("✅ Core Data saved successfully")
        } catch {
            print("❌ Save error: \(error)")
        }
    }
    
    func saveBackground(_ context: NSManagedObjectContext) {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
            print("✅ Background save successful")
        } catch {
            print("❌ Background save error: \(error)")
        }
    }
    
    // Debug method to check Core Data setup
    func debugSetup() {
        print("🔍 Core Data Debug:")
        print("Container name: \(persistentContainer.name)")
        print("Model entities:")
        
        for entity in persistentContainer.managedObjectModel.entities {
            print("  - \(entity.name ?? "Unknown Entity")")
            if let className = entity.managedObjectClassName {
                print("    Class: \(className)")
            }
        }
        
        // Test entity creation
        if let entity = NSEntityDescription.entity(forEntityName: "CacheEntry", in: context) {
            print("✅ CacheEntry entity found and accessible")
        } else {
            print("❌ CacheEntry entity NOT found")
        }
    }
}
