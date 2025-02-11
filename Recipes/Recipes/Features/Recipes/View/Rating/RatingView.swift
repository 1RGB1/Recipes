//
//  RatingView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

struct RatingView: View {
    
    var rating: Double
    
    var body: some View {
        VStack {
            HStack {
                let separation = rating.seperate()
                ForEach(0..<separation.int, id: \.self) { _ in
                    StarView(fillValue: 1)
                }
                StarView(fillValue: separation.decimal)
            }
        }
    }
}

#Preview {
    RatingView(rating: 4.5)
}
