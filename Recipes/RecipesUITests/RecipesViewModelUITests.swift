//
//  RecipesViewModelUITests.swift
//  RecipesUITests
//
//  Created by Ahmad Ragab on 10/02/2025.
//

import XCTest

@MainActor
final class RecipesViewModelUITests: XCTestCase {
    
    override func setUp() {
        continueAfterFailure = false
    }

    override func tearDown() {}
    
//    func testLoadingIndicatorAppears() throws {
//        let app = XCUIApplication()
//        app.launch()
//        let scrollViewsQuery = app.scrollViews
//        let elementsQuery = scrollViewsQuery.scrollViews
//        let loadingIndicator = elementsQuery.activityIndicators["loading"]
//        XCTAssertTrue(loadingIndicator.exists, "Loading indicator should be visible while fetching data.")
//    }
    
//    func testLoadingIndicatorAppears() throws {
//        let loadingIndicator = app.otherElements["loading"]
//        XCTAssertTrue(loadingIndicator.exists, "Loading indicator should be visible while fetching data.")
//    }
                    
//    func testErrorStateAppears() throws {
//        let errorImage = app.images["errorImage"]
//        let errorText = app.staticTexts["errorText"]
//        
//        XCTAssertTrue(errorImage.exists, "Error image should appear on error.")
//        XCTAssertTrue(errorText.exists, "Error text should appear on error.")
//    }
//    
//    func testRecipesListAppears() throws {
//        let app = XCUIApplication()
//        app.launch()
//        let firstRecipe = app.buttons["recipeClassic Margherita Pizza"]
//        XCTAssertTrue(firstRecipe.waitForExistence(timeout: 10), "Recipe list should be displayed after loading.")
//    }
//    
//    func testPaginationLoadingIndicatorAppears() throws {
//        let paginationLoading = app.otherElements["paginationLoading"]
//        
//        let lastRecipe = app.buttons.element(boundBy: app.buttons.count - 1)
//        lastRecipe.swipeUp()
//        
//        XCTAssertTrue(paginationLoading.waitForExistence(timeout: 5), "Pagination loading should appear when scrolling to the last item.")
//    }
}
