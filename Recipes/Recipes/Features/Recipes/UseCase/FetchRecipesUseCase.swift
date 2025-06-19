//
//  FetchRecipesUseCase.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import Foundation

protocol FetchRecipesUseCaseProtocol {
    func execute(limit: Int, skip: Int) async throws -> RecipeResponse
    func search(query: String) async throws -> RecipeResponse
}

class FetchRecipesUseCase: FetchRecipesUseCaseProtocol {
    private let repository: RecipeRepositoryProtocol
    
    init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(limit: Int, skip: Int) async throws -> RecipeResponse {
        return try await repository.fetchRecipes(limit: limit, skip: skip)
    }
    
    func search(query: String) async throws -> RecipeResponse {
        return try await repository.searchRecipes(query: query)
    }
}
