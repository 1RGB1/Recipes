//
//  Logging.swift
//  Recipes
//
//  Created by Sara on 12/02/2025.
//

class Logging {
    static func log(message: String) {
#if DEBUG
        print(message)
#endif
    }
}
