//
//  RecipeDetailViewModel.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

class RecipeDetailViewModel: ObservableObject {
    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
}
