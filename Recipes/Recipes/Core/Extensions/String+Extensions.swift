//
//  String+Extensions.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import Foundation

extension String {
    // Localization support
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
