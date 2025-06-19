//
//  RecipeCardView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe
    @State private var isPressed = false
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImageView(url: recipe.image)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(recipe.name)
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundColor(.primary)
                
                HStack {
                    Label("\(recipe.prepTimeMinutes)m", systemImage: "clock")
                    Label(recipe.cuisine, systemImage: "location")
                }
                .font(.caption)
                .foregroundColor(.secondary)
                
                HStack {
                    RatingView(rating: recipe.rating)
                    
                    Spacer()
                    
                    DifficultyBadge(difficulty: recipe.difficultyLevel)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(
                    color: .black.opacity(0.1),
                    radius: isPressed ? 2 : 8,
                    x: 0,
                    y: isPressed ? 1 : 4
                )
        )
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = pressing
            }
        }, perform: {})
    }
}
