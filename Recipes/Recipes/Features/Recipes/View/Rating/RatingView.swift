//
//  RatingView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

struct RatingView: View {
    let rating: Double
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                Image(systemName: starType(for: index))
                    .foregroundColor(.yellow)
                    .font(.caption)
            }
            Text(String(format: "%.1f", rating))
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
    
    private func starType(for index: Int) -> String {
        let fillLevel = rating - Double(index)
        if fillLevel >= 1.0 {
            return "star.fill"
        } else if fillLevel >= 0.5 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}
