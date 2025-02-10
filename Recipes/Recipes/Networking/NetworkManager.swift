//
//  NetworkManager.swift
//  Recipes
//
//  Created by Ahmad Ragab on 10/02/2025.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T
}

class NetworkManager: NetworkManagerProtocol {
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode == 200
        else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: jsonObject,
                                                     options: [.prettyPrinted]),
              let prettyJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            return nil
        }
        
        return prettyJSON
    }
}
