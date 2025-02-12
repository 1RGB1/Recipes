//
//  NetworkManager.swift
//  Recipes
//
//  Created by Ahmad Ragab on 10/02/2025.
//

import Foundation

enum BusinessError: Error {
    case error(ErrorModel)
}

protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T
}

class NetworkManager: NetworkManagerProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url else {
            Logging.log(message: "❌ Invalid URL: \(endpoint)")
            throw URLError(.badURL)
        }
        
        Logging.log(message: "📡 Fetching data from: \(url)")
        
        let (data, response) = try await session.data(from: url)
        
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode == 200
        else {
            Logging.log(message: "❌ Response is not an HTTPURLResponse")
            throw URLError(.badServerResponse)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            Logging.log(message: "✅ Successfully decoded response")
            
            if let jsonString = String(data: data, encoding: .utf8) {
                Logging.log(message: "\(jsonString)")
            }
            
            return decodedData
        } catch {
            Logging.log(message: "❌ Decoding error: \(error)")
            throw error
        }
    }
}
