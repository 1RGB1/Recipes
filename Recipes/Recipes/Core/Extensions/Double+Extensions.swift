//
//  Double+Extensions.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

extension Double {
    func seperate() -> (int: Int, decimal: Double) {
        let int = Int(self)
        let decimal = self - Double(int)
        return (int, decimal)
    }
}
