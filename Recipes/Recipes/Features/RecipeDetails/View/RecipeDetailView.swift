//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

struct RecipeDetailView: View {
    
    let viewModel: RecipeDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: viewModel.recipe.image)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .accessibilityIdentifier("recipeDetailImage")
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .circular)
                        .fill(.white)
                        .shadow(color: .gray, radius: 2, x: -1, y: 2)
                )
                .padding(.top, 16)
                .padding(.horizontal, 24)
                
                Text(viewModel.recipe.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .accessibilityIdentifier("recipeDetailName")
                
                HStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("Preparation")
                            .font(.caption2)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .foregroundStyle(Color.blue)
                            
                            Text("\(viewModel.recipe.prepTimeMinutes) min")
                                .accessibilityIdentifier("recipeDetailPreparation")
                                .font(.caption2)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Coocking")
                            .font(.caption2)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .foregroundStyle(Color.blue)
                            
                            Text("\(viewModel.recipe.cookTimeMinutes) min")
                                .accessibilityIdentifier("recipeDetailCooking")
                                .font(.caption2)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Calories")
                            .font(.caption2)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "flame.fill")
                                .foregroundStyle(Color.red)
                            
                            Text("\(viewModel.recipe.caloriesPerServing) Kcal")
                                .accessibilityIdentifier("recipeDetailCalories")
                                .font(.caption2)
                        }
                    }
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Ingredients")
                            .accessibilityIdentifier("recipeDetailIngredients")
                            .font(.title3)
                        
                        ForEach(viewModel.recipe.ingredients, id: \.self) {
                            Text("👉🏻 \($0)")
                                .font(.callout)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Instructions")
                            .accessibilityIdentifier("recipeDetailInstructions")
                            .font(.title3)
                        
                        ForEach(viewModel.recipe.instructions, id: \.self) {
                            Text("👉🏻 \($0)")
                                .font(.callout)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .background(Color.orange.ignoresSafeArea(.all))
    }
}

#Preview {
    RecipeDetailView(
        viewModel: RecipeDetailViewModel(
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
    )
}
