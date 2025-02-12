//
//  RecipesView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

struct RecipesView: View {
    
    @StateObject private var viewModel = RecipesViewModel()
    @State private var searchText = ""
    
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
                            Spacer()
                            
                            Image(systemName: "x.circle")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(Color.red)
                            
                            Text("Error: \(errorMessage)")
                                .font(.headline)
                                .foregroundStyle(Color.red)
                            
                            Spacer()
                        }
                    } else {
                        ForEach(viewModel.recipes, id: \.id) { recipe in
                            NavigationLink(
                                destination: RecipeDetailView(
                                    viewModel: RecipeDetailViewModel(recipe: recipe)
                                )
                            ) {
                                RecipeView(recipe: recipe)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            if recipe == viewModel.recipes.last && viewModel.canLoadMore && !viewModel.isSearching {
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
                .padding()
                .searchable(text: $searchText, prompt: "Search recipe")
                .onChange(of: searchText) { _, newValue in
                    viewModel.isSearching = !newValue.isEmpty
                    Task {
                        try? await Task.sleep(for: .seconds(0.5))
                        await viewModel.getRecipesByName(newValue)
                    }
                }
            }
            .background(Color.orange.ignoresSafeArea(.all))
            .navigationTitle("Recipes")
            .task {
                await viewModel.getRecipes()
            }
            .refreshable {
                viewModel.reset()
                searchText = ""
                Task {
                    try? await Task.sleep(for: .seconds(1))
                    await viewModel.getRecipes()
                }
            }
        }
    }
}

#Preview {
    RecipesView()
}
