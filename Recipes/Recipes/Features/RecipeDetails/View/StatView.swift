//
//  StatView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import SwiftUI

struct StatView: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
