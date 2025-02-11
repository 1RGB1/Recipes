//
//  StarView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

struct StarView: View {
    
    var fillValue: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: geometry.size.width * fillValue)
            }
        }
        .mask(
            Image(systemName: "star.fill")
                .resizable()
        )
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    StarView(fillValue: 0.5)
}
