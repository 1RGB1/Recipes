//
//  GetRecipesUseCase.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import Foundation

protocol GetRecipesUseCaseProtocol {
    func getRecipesByPageSize(_ pageSize: Int, skip: Int) async throws -> Recipes
}

class GetRecipesUseCase: GetRecipesUseCaseProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getRecipesByPageSize(_ pageSize: Int, skip: Int) async throws -> Recipes {
        let endpoint = Endpoint(
            path: API.Endpoints.recipes,
            queryItems: [
                URLQueryItem(name: "limit", value: "\(pageSize)"),
                URLQueryItem(name: "skip", value: "\(skip)"),
            ]
        )
        let recipes: Recipes = try await networkManager.fetch(endpoint: endpoint)
        return recipes
    }
}
