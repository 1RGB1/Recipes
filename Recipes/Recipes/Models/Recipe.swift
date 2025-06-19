//
//  Recipe.swift
//  Recipes
//
//  Created by Ahmad Ragab on 10/02/2025.
//

import SwiftUI

struct Recipe: Identifiable, Codable, Equatable, Hashable {
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
    
    var totalTime: Int {
        prepTimeMinutes + cookTimeMinutes
    }
    
    var difficultyLevel: DifficultyLevel {
        DifficultyLevel(rawValue: difficulty.lowercased()) ?? .medium
    }
}

enum DifficultyLevel: String, CaseIterable {
    case easy, medium, hard
    
    var color: Color {
        switch self {
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
}

enum SortOption: String, CaseIterable {
    case name = "Name"
    case rating = "Rating"
    case prepTime = "Prep Time"
    case difficulty = "Difficulty"
    
    func sort(_ recipes: [Recipe]) -> [Recipe] {
        switch self {
        case .name:
            return recipes.sorted { $0.name < $1.name }
        case .rating:
            return recipes.sorted { $0.rating > $1.rating }
        case .prepTime:
            return recipes.sorted { $0.prepTimeMinutes < $1.prepTimeMinutes }
        case .difficulty:
            return recipes.sorted { $0.difficulty < $1.difficulty }
        }
    }
}
