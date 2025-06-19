//
//  NetworkManager.swift
//  Recipes
//
//  Created by Ahmad Ragab on 10/02/2025.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case requestFailed(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response"
        case .serverError(let code):
            return "Server error: \(code)"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        }
    }
}

protocol NetworkServiceProtocol {
    func fetch<T: Codable>(_ endpoint: APIEndpoint) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let securityService: SecurityServiceProtocol
    
    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.waitsForConnectivity = true
        self.session = URLSession(configuration: config)
        self.securityService = SecurityService()
    }
    
    func fetch<T: Codable>(_ endpoint: APIEndpoint) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Add API key securely
        if let apiKey = securityService.getAPIKey() {
            request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                throw NetworkError.serverError(httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
            
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
