//
//  SecurityService.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import SwiftUI

protocol SecurityServiceProtocol {
    func getAPIKey() -> String?
    func encryptData(_ data: Data) -> Data?
    func decryptData(_ data: Data) -> Data?
}

class SecurityService: SecurityServiceProtocol {
    private let keychain = KeychainHelper()
    
    func getAPIKey() -> String? {
        // In production, store securely in Keychain
        return keychain.read(service: "recipe-app", account: "api-key")
    }
    
    func encryptData(_ data: Data) -> Data? {
        // Implement AES encryption
        return CryptoHelper.encrypt(data)
    }
    
    func decryptData(_ data: Data) -> Data? {
        // Implement AES decryption
        return CryptoHelper.decrypt(data)
    }
}
