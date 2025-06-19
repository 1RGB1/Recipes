//
//  RecipePerformanceTests.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import XCTest
@testable import Recipes

class RecipePerformanceTests: XCTestCase {
    
    func testRecipeListScrollingPerformance() {
        measure {
            // Simulate scrolling through large list
            let recipes = Array(repeating: Recipe.mock(), count: 1000)
            let sortedRecipes = SortOption.name.sort(recipes)
            XCTAssertEqual(sortedRecipes.count, 1000)
        }
    }
    
    func testImageCachePerformance() {
        measure {
            let cache = ImageCache.shared
            for i in 0..<100 {
                let key = "test_image_\(i)"
                let image = UIImage(systemName: "photo")!
                cache.cache.setObject(image, forKey: NSString(string: key))
            }
        }
    }
    
    func testSearchPerformance() {
        let recipes = Array(repeating: Recipe.mock(), count: 10000)
        
        measure {
            let filtered = recipes.filter { $0.name.lowercased().contains("pizza") }
            _ = filtered.count
        }
    }
}
