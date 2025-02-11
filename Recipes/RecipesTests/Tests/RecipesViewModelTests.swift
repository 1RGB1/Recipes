//
//  RecipesViewModelTests.swift
//  RecipesTests
//
//  Created by Ahmad Ragab on 10/02/2025.
//

import XCTest
@testable import Recipes

@MainActor
final class RecipesViewModelTests: XCTestCase {
    
    var mockGetRecipesUseCase: MockGetRecipesUseCase!
    var viewModel: RecipesViewModel!

    override func setUp() {
        super.setUp()
        
        mockGetRecipesUseCase = MockGetRecipesUseCase()
        viewModel = RecipesViewModel(useCase: mockGetRecipesUseCase)
    }

    override func tearDown() {
        mockGetRecipesUseCase = nil
        viewModel = nil
        
        super.tearDown()
    }
    
    func test_GetRecipes_Success() {
        // Given
        viewModel.isLoading = true
        viewModel.canLoadMore = true
    }
    
    func test_GetRecipes_NoMoreLoading() async {
        // Given
        viewModel.isLoading = true
        viewModel.canLoadMore = false
        
        // When
        await viewModel.getRecipes()
        
        // Then
        XCTAssertEqual(viewModel.recipes.count, 0)
    }
    
    func test_GetRecipes_FailWithBusiness() async {
        // Given
        viewModel.isLoading = true
        viewModel.canLoadMore = true
        mockGetRecipesUseCase.isSuccess = false
        mockGetRecipesUseCase.isBusinessError = true
        
        // When
        await viewModel.getRecipes()
        
        // Then
        XCTAssertEqual(viewModel.errorMessage, "Hello_Peter")
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_GetRecipes_Fail() async {
        // Given
        viewModel.isLoading = true
        viewModel.canLoadMore = true
        mockGetRecipesUseCase.isSuccess = false
        
        // When
        await viewModel.getRecipes()
        
        // Then
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_GetRecipes_Success() async {
        // Given
        viewModel.isLoading = true
        viewModel.canLoadMore = true
        mockGetRecipesUseCase.isSuccess = true
        
        // When
        await viewModel.getRecipes()
        
        // Then
        XCTAssertEqual(viewModel.recipes.count, 1)
        XCTAssertEqual(viewModel.recipes[0].name, "Classic Margherita Pizza")
        XCTAssertFalse(viewModel.isLoading)
    }
}
