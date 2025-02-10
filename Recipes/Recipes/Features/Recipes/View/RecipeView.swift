//
//  RecipeView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

struct RecipeView: View {
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://cdn.dummyjson.com/recipe-images/1.webp")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100)
            
            VStack {
                Text("Classic Margherita Pizza")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                
                Text("Italian")
                    .font(.body)
                
                Text("Easy")
                    .font(.footnote)
                
                RatingView(rating: .constant(4.6))
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
    RecipeView()
}
