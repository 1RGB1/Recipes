//
//  NetworkManagerTests.swift
//  RecipesTests
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import XCTest
@testable import Recipes

final class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    var urlSession: URLSession!

    override func setUp() {
        super.setUp()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        
        networkManager = NetworkManager(session: urlSession)
    }

    override func tearDown() {
        urlSession = nil
        networkManager = nil
        
        MockURLProtocol.mockResponseData = nil
        MockURLProtocol.mockResponse = nil
        MockURLProtocol.mockError = nil
        
        super.tearDown()
    }
    
    func testFetch_Success() async {
        // Given
        do {
            MockURLProtocol.mockResponseData = try MockHandler.readJSONFileToData("recipes")
            MockURLProtocol.mockResponse = HTTPURLResponse(
                url: URL(string: "\(API.scheme)//\(API.host)")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )
            let endpoint = Endpoint(
                path: API.Endpoints.recipes,
                queryItems: [
                    URLQueryItem(name: "limit", value: "\(0)")
                ]
            )
            
            let recipes: Recipes = try await networkManager.fetch(endpoint: endpoint)
            
            // Then
            XCTAssertTrue(recipes.recipes.count > 0)
            XCTAssertEqual(recipes.recipes[0].name, "Classic Margherita Pizza")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFetch_Fail() async {
        // Given
        MockURLProtocol.mockError = URLError(.badServerResponse)
        let endpoint = Endpoint(
            path: API.Endpoints.recipes,
            queryItems: [
                URLQueryItem(name: "limit", value: "\(0)")
            ]
        )
        
        // When
        do {
            let _: Recipes = try await networkManager.fetch(endpoint: endpoint)
            // Then
            XCTFail("Expected to throw error")
        } catch let error as URLError {
            // Then
            XCTAssertEqual(error.code, .badServerResponse)
        } catch {
            // Then
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }
    
    func testFetch_FailWithErrorCode() async {
        // Given
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: "\(API.scheme)//\(API.host)")!,
            statusCode: 404,
            httpVersion: nil,
            headerFields: nil
        )
        let endpoint = Endpoint(
            path: API.Endpoints.recipes,
            queryItems: [
                URLQueryItem(name: "limit", value: "\(0)")
            ]
        )
        
        // When
        do {
            let _: Recipes = try await networkManager.fetch(endpoint: endpoint)
            // Then
            XCTFail("Expected to throw error")
        } catch let error as URLError {
            // Then
            XCTAssertEqual(error.code, .badServerResponse)
        } catch {
            // Then
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }
}
