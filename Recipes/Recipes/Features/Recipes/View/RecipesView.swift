//
//  RecipesView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

struct RecipesView: View {
    
    @StateObject private var viewModel = RecipesViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    if viewModel.isLoading {
                        VStack {
                            ProgressView("Loading...")
                                .frame(width: 200, height: 200, alignment: .center)
                        }
                    } else if let errorMessage = viewModel.errorMessage {
                        VStack(alignment: .center) {
                            Image(systemName: "x.circle")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(Color.red)
                            
                            Text("Error: \(errorMessage)")
                                .font(.headline)
                                .foregroundStyle(Color.red)
                        }
                    } else {
                        ForEach(viewModel.recipes) { recipe in
                            NavigationLink(destination: Text(recipe.name)) {
                                RecipeView(recipe: recipe)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            if recipe == viewModel.recipes.last {
                                if viewModel.canLoadMore {
                                    ProgressView()
                                        .onAppear {
                                            Task {
                                                await viewModel.getRecipes()
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Recipes")
            .task {
                await viewModel.getRecipes()
            }
        }
    }
}

#Preview {
    RecipesView()
}
