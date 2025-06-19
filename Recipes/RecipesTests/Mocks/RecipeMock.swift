//
//  RecipiesMock.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

@testable import Recipes

extension Recipe {
    static func mock(
        id: Int = 1,
        name: String = "Mock Recipe",
        rating: Double = 4.5,
        prepTimeMinutes: Int = 30,
        difficulty: String = "Easy"
    ) -> Recipe {
        Recipe(
            id: id,
            name: name,
            ingredients: ["Ingredient 1", "Ingredient 2"],
            instructions: ["Step 1", "Step 2"],
            prepTimeMinutes: prepTimeMinutes,
            cookTimeMinutes: 15,
            servings: 4,
            difficulty: difficulty,
            cuisine: "Test Cuisine",
            caloriesPerServing: 300,
            tags: ["Test"],
            userId: 1,
            image: "https://example.com/image.jpg",
            rating: rating,
            reviewCount: 10,
            mealType: ["Dinner"]
        )
    }
}
