//
//  RecipesApp.swift
//  Recipes
//
//  Created by Ahmad Ragab on 10/02/2025.
//

import SwiftUI

@main
struct RecipeApp: App {
    let container = DIContainer.shared
    let coreDataManager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            container.makeRecipeListView()
                .environment(\.managedObjectContext, coreDataManager.context)
                .preferredColorScheme(.light)
        }
    }
}
