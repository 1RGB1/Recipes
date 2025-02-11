//
//  Recipes.swift
//  Recipes
//
//  Created by Ahmad Ragab on 10/02/2025.
//

struct Recipes: Decodable {
    let recipes: [Recipe]
    let total: Int
    let skip: Int
    let limit: Int
    
    init(recipes: [Recipe] = [], total: Int = 0, skip: Int = 0, limit: Int = 0) {
        self.recipes = recipes
        self.total = total
        self.skip = skip
        self.limit = limit
    }
}
