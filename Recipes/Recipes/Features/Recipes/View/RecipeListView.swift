//
//  RecipeListView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel: RecipeListViewModel
    @State private var showingSortOptions = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).ignoresSafeArea()
                
                if viewModel.isLoading && viewModel.recipes.isEmpty {
                    LoadingView()
                } else if let error = viewModel.error {
                    ErrorView(message: error) {
                        viewModel.loadInitialData()
                    }
                } else {
                    recipesList
                }
            }
            .navigationTitle("Recipes")
            .searchable(text: $viewModel.searchText, prompt: "Search recipes...")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    sortButton
                }
            }
            .refreshable {
                await viewModel.refresh()
            }
        }
    }
    
    private var recipesList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.filteredRecipes) { recipe in
                    NavigationLink(destination: DIContainer.shared.makeRecipeDetailView(recipe: recipe)) {
                        RecipeCardView(recipe: recipe)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
                    .onAppear {
                        if recipe == viewModel.filteredRecipes.last {
                            viewModel.loadMoreRecipes()
                        }
                    }
                }
                
                if viewModel.isLoading && !viewModel.recipes.isEmpty {
                    ProgressView()
                        .scaleEffect(1.2)
                        .padding()
                }
            }
            .padding()
        }
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: viewModel.filteredRecipes)
    }
    
    private var sortButton: some View {
        Button(action: { showingSortOptions.toggle() }) {
            Image(systemName: "arrow.up.arrow.down")
                .foregroundColor(.primary)
        }
        .confirmationDialog("Sort by", isPresented: $showingSortOptions) {
            ForEach(SortOption.allCases, id: \.self) { option in
                Button(option.rawValue) {
                    withAnimation(.spring()) {
                        viewModel.selectedSort = option
                    }
                }
            }
        }
    }
}
