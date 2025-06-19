//
//  Constants.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import Foundation

enum Constants {
    enum UI {
        static let cornerRadius: CGFloat = 12
        static let padding: CGFloat = 16
        static let cardShadowRadius: CGFloat = 8
    }
    
    enum Animation {
        static let defaultDuration: Double = 0.3
        static let springResponse: Double = 0.6
        static let springDamping: Double = 0.8
    }
    
    enum Cache {
        static let recipesCacheKey = "cached_recipes"
        static let maxCacheAge: TimeInterval = 3600
    }
}
