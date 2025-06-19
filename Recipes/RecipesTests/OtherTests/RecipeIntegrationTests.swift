//
//  RecipeIntegrationTests.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import XCTest
@testable import Recipes

class RecipeIntegrationTests: XCTestCase {
    var networkService: NetworkService!
    var cacheService: CacheService!
    var repository: RecipeRepository!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService()
        cacheService = CacheService()
        repository = RecipeRepository(networkService: networkService, cacheService: cacheService)
    }
    
    func testEndToEndRecipeFetching() async throws {
        // Given
        let expectation = XCTestExpectation(description: "Fetch recipes")
        
        // When
        do {
            let response = try await repository.fetchRecipes(limit: 10, skip: 0)
            
            // Then
            XCTAssertGreaterThan(response.recipes.count, 0)
            XCTAssertEqual(response.limit, 10)
            expectation.fulfill()
        } catch {
            XCTFail("Failed to fetch recipes: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 10.0)
    }
    
    func testCacheIntegration() async {
        // Given
        let mockRecipe = Recipe.mock()
        let key = "test_recipe"
        
        // When
        await cacheService.save(mockRecipe, key: key)
        let cachedRecipe: Recipe? = await cacheService.load(Recipe.self, key: key)
        
        // Then
        XCTAssertNotNil(cachedRecipe)
        XCTAssertEqual(cachedRecipe?.name, mockRecipe.name)
    }
}
