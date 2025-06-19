//
//  DifficultyBadge.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import SwiftUI

struct DifficultyBadge: View {
    let difficulty: DifficultyLevel
    
    var body: some View {
        Text(difficulty.rawValue.capitalized)
            .font(.caption2)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(difficulty.color.opacity(0.2))
            .foregroundColor(difficulty.color)
            .clipShape(Capsule())
    }
}
