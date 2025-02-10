//
//  Endpoint.swift
//  Recipes
//
//  Created by Ahmad Ragab on 10/02/2025.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
