//
//  RecipeDetailView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

struct RecipeDetailView: View {
    let viewModel: RecipeDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                headerImage
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    statsSection
                    ingredientsSection
                    instructionsSection
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Share") {
                    // Share functionality
                }
            }
        }
    }
    
    private var headerImage: some View {
        AsyncImageView(url: viewModel.recipe.image)
            .frame(height: 250)
            .clipped()
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.recipe.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                RatingView(rating: viewModel.recipe.rating)
                Spacer()
                DifficultyBadge(difficulty: viewModel.recipe.difficultyLevel)
            }
        }
    }
    
    private var statsSection: some View {
        HStack(spacing: 30) {
            StatView(icon: "clock", value: "\(viewModel.recipe.prepTimeMinutes)m", label: "Prep")
            StatView(icon: "flame", value: "\(viewModel.recipe.caloriesPerServing)", label: "Cal")
            StatView(icon: "person.2", value: "\(viewModel.recipe.servings)", label: "Serves")
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Ingredients")
                .font(.title2)
                .fontWeight(.semibold)
            
            ForEach(Array(viewModel.recipe.ingredients.enumerated()), id: \.offset) { index, ingredient in
                HStack {
                    Text("\(index + 1).")
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    Text(ingredient)
                    Spacer()
                }
                .padding(.vertical, 4)
            }
        }
    }
    
    private var instructionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Instructions")
                .font(.title2)
                .fontWeight(.semibold)
            
            ForEach(Array(viewModel.recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                HStack(alignment: .top) {
                    Text("\(index + 1).")
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .frame(width: 20, alignment: .leading)
                    Text(instruction)
                        .lineLimit(nil)
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
    }
}
