//
//  RatingView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Double
    
    var body: some View {
        VStack {
            HStack {
                let separation = rating.getItSeperated()
                ForEach(0..<separation.int, id: \.self) { _ in
                    StarView(fillValue: 1)
                }
                StarView(fillValue: separation.decimal)
            }
        }
    }
}

#Preview {
    RatingView(rating: .constant(4.5))
}


extension Double {
    func getItSeperated() -> (int: Int, decimal: Double) {
        let int = Int(self)
        let decimal = self - Double(int)
        return (int, decimal)
    }
}
