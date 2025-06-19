//
//  DIContainer.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import SwiftUI

class DIContainer: ObservableObject {
    static let shared = DIContainer()
    
    // MARK: - Core Services
    lazy var networkService: NetworkServiceProtocol = NetworkService()
    lazy var cacheService: CacheServiceProtocol = CacheService()
    lazy var securityService: SecurityServiceProtocol = SecurityService()
    
    // MARK: - Repositories
    lazy var recipeRepository: RecipeRepositoryProtocol = RecipeRepository(
        networkService: networkService,
        cacheService: cacheService
    )
    
    // MARK: - Use Cases
    lazy var fetchRecipesUseCase: FetchRecipesUseCaseProtocol = FetchRecipesUseCase(
        repository: recipeRepository
    )
    
    // MARK: - View Factories
    @MainActor
    func makeRecipeListView() -> RecipeListView {
        let viewModel = RecipeListViewModel(
            fetchRecipesUseCase: fetchRecipesUseCase
        )
        return RecipeListView(viewModel: viewModel)
    }
    
    func makeRecipeDetailView(recipe: Recipe) -> RecipeDetailView {
        let viewModel = RecipeDetailViewModel(recipe: recipe)
        return RecipeDetailView(viewModel: viewModel)
    }
}
