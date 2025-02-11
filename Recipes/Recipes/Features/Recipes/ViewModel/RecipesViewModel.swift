//
//  RecipesViewModel.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

@MainActor
class RecipesViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var isLoading = true
    @Published var errorMessage: String?
    
    private let pageSize = 10
    private var skipItems = 0
    var canLoadMore = true
    private let useCase: GetRecipesUseCaseProtocol
    
    init(useCase: GetRecipesUseCaseProtocol = GetRecipesUseCase()) {
        self.useCase = useCase
    }
    
    func getRecipes() async {
        if isLoading && !canLoadMore { return }
        errorMessage = nil
        
        do {
            let paginatedRecipes = try await useCase.getRecipesByPageSize(pageSize, skip: skipItems)
            if paginatedRecipes.recipes.count > 0 {
                recipes.append(contentsOf: paginatedRecipes.recipes)
                skipItems += pageSize
            } else {
                canLoadMore = false
            }
        } catch {
            if let err = error as? BusinessError {
                if case let .error(errorModel) = err {
                    errorMessage = errorModel.message
                }
            } else {
                errorMessage = error.localizedDescription
            }
        }
        
        isLoading = false
    }
    
    func reset() {
        recipes = []
        isLoading = true
        errorMessage = nil
        skipItems = 0
        canLoadMore = true
    }
}
