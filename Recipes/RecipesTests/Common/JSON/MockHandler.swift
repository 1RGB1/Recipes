//
//  MockHandlerr.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import Foundation
@testable import Recipes

enum JSONFileError: Error {
    case fileNotFound
    case decodingFailed(Error)
    case readingFile(Error)
}

class MockHandler {
    static func readJSONFileToModel<T: Decodable>(_ fileName: String) throws -> T {
        guard let fileURL = Bundle(for: Self.self).url(forResource: fileName, withExtension: "json") else {
            throw JSONFileError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw JSONFileError.decodingFailed(error)
        }
    }
    
    static func readJSONFileToData(_ fileName: String) throws -> Data {
        guard let fileURL = Bundle(for: Self.self).url(forResource: fileName, withExtension: "json") else {
            throw JSONFileError.fileNotFound
        }
        
        do {
            return try Data(contentsOf: fileURL)
        } catch {
            throw JSONFileError.readingFile(error)
        }
    }
}
