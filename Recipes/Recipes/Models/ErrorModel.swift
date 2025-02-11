//
//  ErrorModel.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

struct ErrorModel: Decodable {
    let status: Int
    let title: String
    let type: String
    let detail: String
    let message: String
}
