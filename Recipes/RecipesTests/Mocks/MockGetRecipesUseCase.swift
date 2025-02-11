//
//  MockGetRecipesUseCase.swift
//  Recipes
//
//  Created by Sara on 11/02/2025.
//

@testable import Recipes

enum MockError: Error {
    case unknown
}

class MockGetRecipesUseCase: GetRecipesUseCaseProtocol {
    
    var isSuccess = true
    var isBusinessError = false
    
    func getRecipesByPageSize(_ pageSize: Int, skip: Int) async throws -> Recipes {
        if isSuccess {
            return try MockHandler.readJSONFileToModel("recipes")
        } else {
            if isBusinessError {
                let errorModel: ErrorModel = try MockHandler.readJSONFileToModel("error")
                throw BusinessError.error(errorModel)
            } else {
                throw MockError.unknown
            }
        }
    }
}
