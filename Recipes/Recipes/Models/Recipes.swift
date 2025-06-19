//
//  Recipes.swift
//  Recipes
//
//  Created by Ahmad Ragab on 10/02/2025.
//

struct RecipeResponse: Codable {
    let recipes: [Recipe]
    let total: Int
    let skip: Int
    let limit: Int
}
