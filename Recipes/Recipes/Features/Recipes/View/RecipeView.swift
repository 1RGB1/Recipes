//
//  RecipeView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

struct RecipeView: View {
    
    var recipe: Recipe
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            
            VStack {
                Text(recipe.name)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                Text(recipe.cuisine)
                    .font(.body)
                
                Text(recipe.difficulty)
                    .font(.footnote)
                
                RatingView(rating: recipe.rating)
                    .frame(height: 20)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .circular)
                .fill(.white)
                .shadow(color: .gray, radius: 2, x: -1, y: 2)
        )
    }
}

#Preview {
    RecipeView(
        recipe: Recipe(
            id: 1,
            name: "Classic Margherita Pizza",
            ingredients: [
                "Pizza dough",
                "Tomato sauce",
                "Fresh mozzarella cheese",
                "Fresh basil leaves",
                "Olive oil",
                "Salt and pepper to taste"
            ],
            instructions: [
                "Preheat the oven to 475°F (245°C).",
                "Roll out the pizza dough and spread tomato sauce evenly.",
                "Top with slices of fresh mozzarella and fresh basil leaves.",
                "Drizzle with olive oil and season with salt and pepper.",
                "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
                "Slice and serve hot."
            ],
            prepTimeMinutes: 20,
            cookTimeMinutes: 15,
            servings: 4,
            difficulty: "Easy",
            cuisine: "Italian",
            caloriesPerServing: 300,
            tags: [
                "Pizza",
                "Italian"
            ],
            userId: 45,
            image: "https://cdn.dummyjson.com/recipe-images/1.webp",
            rating: 4.6,
            reviewCount: 3,
            mealType: [
                "Dinner"]
        )
    )
}
