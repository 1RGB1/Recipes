//
//  LoadingView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 20) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading delicious recipes...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}
