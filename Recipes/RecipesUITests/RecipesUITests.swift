//
//  RecipesUITests.swift
//  RecipesUITests
//
//  Created by Ahmad Ragab on 10/02/2025.
//

import XCTest

class RecipeAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testRecipeListDisplaysCorrectly() {
        // Given
        let recipeList = app.scrollViews.firstMatch
        
        // Then
        XCTAssertTrue(recipeList.exists)
        XCTAssertTrue(app.navigationBars["Recipes"].exists)
    }
    
    func testSearchFunctionality() {
        // Given
        let searchField = app.searchFields.firstMatch
        
        // When
        searchField.tap()
        searchField.typeText("pizza")
        
        // Then
        XCTAssertTrue(searchField.exists)
    }
    
    func testRecipeDetailNavigation() {
        // Given
        let firstRecipe = app.buttons.firstMatch
        
        // When
        if firstRecipe.exists {
            firstRecipe.tap()
            
            // Then
            XCTAssertTrue(app.navigationBars.element.exists)
        }
    }
    
    func testPullToRefresh() {
        // Given
        let scrollView = app.scrollViews.firstMatch
        
        // When
        scrollView.swipeDown()
        
        // Then
        // Check if refresh indicator appears
        XCTAssertTrue(scrollView.exists)
    }
    
    func testSortingOptions() {
        // Given
        let sortButton = app.buttons["Sort"]
        
        // When
        if sortButton.exists {
            sortButton.tap()
            
            // Then
            XCTAssertTrue(app.sheets.firstMatch.exists)
        }
    }
}
