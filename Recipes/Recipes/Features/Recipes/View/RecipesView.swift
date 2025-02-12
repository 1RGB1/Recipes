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
                                .accessibilityIdentifier("loading")
                        }
                    } else if let errorMessage = viewModel.errorMessage {
                        VStack(alignment: .center) {
                            Spacer()
                            
                            Image(systemName: "x.circle")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(Color.red)
                                .accessibilityIdentifier("errorImage")
                            
                            Text("Error: \(errorMessage)")
                                .font(.headline)
                                .foregroundStyle(Color.red)
                                .accessibilityIdentifier("errorText")
                            
                            Spacer()
                        }
                    } else {
                        ForEach(viewModel.recipes) { recipe in
                            NavigationLink(
                                destination: RecipeDetailView(
                                    viewModel: RecipeDetailViewModel(recipe: recipe)
                                )
                            ) {
                                RecipeView(recipe: recipe)
                                    .accessibilityIdentifier("recipe\(recipe.name)")
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            if recipe == viewModel.recipes.last && viewModel.canLoadMore {
                                ProgressView()
                                    .onAppear {
                                        Task {
                                            await viewModel.getRecipes()
                                        }
                                    }
                                    .accessibilityIdentifier("paginationLoading")
                            }
                        }
                    }
                }
                .padding()
            }
            .background(Color.orange.ignoresSafeArea(.all))
            .navigationTitle("Recipes")
            .task {
                await viewModel.getRecipes()
            }
            .refreshable {
                viewModel.reset()
                Task {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    await viewModel.getRecipes()
                }
            }
        }
    }
}

#Preview {
    RecipesView()
}
