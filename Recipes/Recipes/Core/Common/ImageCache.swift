//
//  ImageCache.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    func loadImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let key = NSString(string: urlString)
        
        if let cachedImage = cache.object(forKey: key) {
            completion(.success(cachedImage))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            self?.cache.setObject(image, forKey: key)
            completion(.success(image))
        }.resume()
    }
}
