//
//  API.swift
//  Recipes
//
//  Created by Sara on 10/02/2025.
//

enum API {
    static let scheme = "https"
    static let host = "dummyjson.com"
    
    enum Endpoints {
        static let recipes = "/recipes"
        static let search = "/recipes/search"
    }
}
