//
//  MockFetchRecipesUseCase.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

@testable import Recipes

class MockFetchRecipesUseCase: FetchRecipesUseCaseProtocol {
    var mockResponse: RecipeResponse = RecipeResponse(recipes: [], total: 0, skip: 0, limit: 0)
    var shouldFail = false
    var onSearch: (() -> Void)?
    
    func execute(limit: Int, skip: Int) async throws -> RecipeResponse {
        if shouldFail {
            throw NetworkError.invalidResponse
        }
        return mockResponse
    }
    
    func search(query: String) async throws -> RecipeResponse {
        onSearch?()
        if shouldFail {
            throw NetworkError.invalidResponse
        }
        return mockResponse
    }
}
