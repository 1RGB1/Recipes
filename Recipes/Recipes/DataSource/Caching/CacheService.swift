//
//  CacheService.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import SwiftUI
import CoreData

protocol CacheServiceProtocol {
    func save<T: Codable>(_ object: T, key: String) async
    func load<T: Codable>(_ type: T.Type, key: String) async -> T?
    func remove(key: String) async
}


class CacheService: CacheServiceProtocol {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CachedModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data error: \(error)")
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func save<T: Codable>(_ object: T, key: String) async {
        await MainActor.run {
            // Save to Core Data
            let entity = RecipesCachedModel(context: context)
            entity.key = key
            entity.data = try? JSONEncoder().encode(object)
            entity.timestamp = Date()
            
            try? context.save()
        }
    }
    
    func load<T: Codable>(_ type: T.Type, key: String) async -> T? {
        return await MainActor.run {
            let request: NSFetchRequest<RecipesCachedModel> = RecipesCachedModel.fetchRequest()
            request.predicate = NSPredicate(format: "key == %@", key)
            
            guard let cachedData = try? context.fetch(request).first,
                  let data = cachedData.data else {
                return nil
            }
            
            return try? JSONDecoder().decode(type, from: data)
        }
    }
    
    func remove(key: String) async {
        await MainActor.run {
            let request: NSFetchRequest<RecipesCachedModel> = RecipesCachedModel.fetchRequest()
            request.predicate = NSPredicate(format: "key == %@", key)
            
            if let objects = try? context.fetch(request) {
                objects.forEach(context.delete)
                try? context.save()
            }
        }
    }
}
