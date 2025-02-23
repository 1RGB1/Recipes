//
//  Recipe.swift
//  Recipes
//
//  Created by Ahmad Ragab on 10/02/2025.
//

struct Recipe: Identifiable, Decodable, Equatable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let prepTimeMinutes: Int
    let cookTimeMinutes: Int
    let servings: Int
    let difficulty: String
    let cuisine: String
    let caloriesPerServing: Int
    let tags: [String]
    let userId: Int
    let image: String
    let rating: Double
    let reviewCount: Int
    let mealType: [String]
}
