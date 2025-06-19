//
//  APIEndpoint.swift
//  Recipes
//
//  Created by Ahmad Ragab on 10/02/2025.
//

import SwiftUI

enum APIEndpoint {
    case recipes(limit: Int, skip: Int)
    case search(query: String)
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dummyjson.com"
        
        switch self {
        case .recipes(let limit, let skip):
            components.path = "/recipes"
            components.queryItems = [
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "skip", value: "\(skip)")
            ]
        case .search(let query):
            components.path = "/recipes/search"
            components.queryItems = [
                URLQueryItem(name: "q", value: query)
            ]
        }
        
        return components.url
    }
}

struct AppConfig {
    static let apiBaseURL = "https://dummyjson.com"
    static let cacheExpirationTime: TimeInterval = 3600 // 1 hour
    static let maxCacheSize = 100 * 1024 * 1024 // 100MB
    static let requestTimeout: TimeInterval = 30
}
