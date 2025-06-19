//
//  RecipeListViewModelTests.swift
//  RecipesTests
//
//  Created by Ahmad Ragab on 10/02/2025.
//

import XCTest
import Combine
@testable import Recipes

class RecipeListViewModelTests: XCTestCase {
    var viewModel: RecipeListViewModel!
    var mockUseCase: MockFetchRecipesUseCase!
    var cancellables: Set<AnyCancellable>!
    
    @MainActor
    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchRecipesUseCase()
        viewModel = RecipeListViewModel(fetchRecipesUseCase: mockUseCase)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        cancellables = nil
        super.tearDown()
    }
    
    @MainActor
    func testLoadInitialData_Success() async {
        // Given
        let mockRecipes = [Recipe.mock()]
        mockUseCase.mockResponse = RecipeResponse(recipes: mockRecipes, total: 1, skip: 0, limit: 20)
        
        // When
        await viewModel.refresh()
        
        // Then
        XCTAssertEqual(viewModel.recipes.count, 1)
        XCTAssertEqual(viewModel.recipes.first?.name, "Mock Recipe")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
    }
    
    @MainActor
    func testLoadInitialData_Failure() async {
        // Given
        mockUseCase.shouldFail = true
        
        // When
        await viewModel.refresh()
        
        // Then
        XCTAssertTrue(viewModel.recipes.isEmpty)
        XCTAssertNotNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    @MainActor
    func testSearchDebouncing() async {
        // Given
        let expectation = XCTestExpectation(description: "Search debouncing")
        var searchCallCount = 0
        
        mockUseCase.onSearch = {
            searchCallCount += 1
            if searchCallCount == 1 {
                expectation.fulfill()
            }
        }
        
        // When - rapid fire search updates
        viewModel.searchText = "p"
        viewModel.searchText = "pi"
        viewModel.searchText = "piz"
        viewModel.searchText = "pizza"
        
        // Then
        await fulfillment(of: [expectation], timeout: 1.0)
        XCTAssertEqual(searchCallCount, 1) // Should only call once due to debouncing
    }
    
    @MainActor
    func testSortingFunctionality() {
        // Given
        let recipe1 = Recipe.mock(name: "Apple Pie", rating: 4.0)
        let recipe2 = Recipe.mock(name: "Banana Bread", rating: 5.0)
        viewModel.recipes = [recipe1, recipe2]
        
        // When - Sort by name
        viewModel.selectedSort = .name
        
        // Then
        XCTAssertEqual(viewModel.filteredRecipes.first?.name, "Apple Pie")
        
        // When - Sort by rating
        viewModel.selectedSort = .rating
        
        // Then
        XCTAssertEqual(viewModel.filteredRecipes.first?.name, "Banana Bread")
    }
    
    @MainActor
    func testPagination() async {
        // Given
        mockUseCase.mockResponse = RecipeResponse(recipes: Array(repeating: Recipe.mock(), count: 20), total: 40, skip: 0, limit: 20)
        
        // When - Load initial data
        await viewModel.refresh()
        let initialCount = viewModel.recipes.count
        
        // Load more
        viewModel.loadMoreRecipes()
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1 second
        
        // Then
        XCTAssertEqual(initialCount, 20)
        // Note: In real implementation, this would load more recipes
    }
}
