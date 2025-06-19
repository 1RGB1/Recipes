//
//  RecipeRepository.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import SwiftUI

protocol RecipeRepositoryProtocol {
    func fetchRecipes(limit: Int, skip: Int) async throws -> RecipeResponse
    func searchRecipes(query: String) async throws -> RecipeResponse
}

class RecipeRepository: RecipeRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let cacheService: CacheServiceProtocol
    
    init(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    func fetchRecipes(limit: Int, skip: Int) async throws -> RecipeResponse {
        let cacheKey = "recipes_\(limit)_\(skip)"
        
        // Try cache first (offline mode)
        if let cached: RecipeResponse = await cacheService.load(RecipeResponse.self, key: cacheKey) {
            return cached
        }
        
        // Fetch from network
        do {
            let response: RecipeResponse = try await networkService.fetch(.recipes(limit: limit, skip: skip))
            await cacheService.save(response, key: cacheKey)
            return response
        } catch {
            // If network fails, try to return any cached data
            if let cached: RecipeResponse = await cacheService.load(RecipeResponse.self, key: "recipes_fallback") {
                return cached
            }
            throw error
        }
    }
    
    func searchRecipes(query: String) async throws -> RecipeResponse {
        let cacheKey = "search_\(query)"
        
        if let cached: RecipeResponse = await cacheService.load(RecipeResponse.self, key: cacheKey) {
            return cached
        }
        
        let response: RecipeResponse = try await networkService.fetch(.search(query: query))
        await cacheService.save(response, key: cacheKey)
        return response
    }
}
