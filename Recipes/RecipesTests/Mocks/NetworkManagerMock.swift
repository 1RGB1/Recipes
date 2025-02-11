//
//  NetworkManagerMock.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import Foundation
@testable import Recipes

enum NetworkError: Error {
    case error(ErrorModel)
}

class NetworkManagerMock: NetworkManagerProtocol {
    
    var isSuccess = true
    
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        if isSuccess {
            return try MockHandler.readJSONFileToModel("recipes")
        } else {
            throw URLError(.badServerResponse)
        }
    }
}
