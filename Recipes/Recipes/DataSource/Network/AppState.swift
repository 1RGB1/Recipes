//
//  AppState.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var isOnline = true
    @Published var lastSyncDate: Date?
    
    private var reachability: NetworkReachability
    
    init() {
        self.reachability = NetworkReachability()
        setupNetworkMonitoring()
    }
    
    private func setupNetworkMonitoring() {
        reachability.startMonitoring { [weak self] isConnected in
            DispatchQueue.main.async {
                self?.isOnline = isConnected
            }
        }
    }
}

class NetworkReachability {
    func startMonitoring(completion: @escaping (Bool) -> Void) {
        // Implement network reachability monitoring
        completion(true)
    }
}
