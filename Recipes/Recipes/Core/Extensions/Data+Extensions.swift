//
//  Data+Extensions.swift
//  Recipes
//
//  Created by Ahmad Ragab on 11/02/2025.
//

import Foundation

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: jsonObject,
                                                     options: [.prettyPrinted]),
              let prettyJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            return nil
        }
        
        return prettyJSON
    }
}
