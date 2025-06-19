//
//  AsyncImageView.swift
//  Recipes
//
//  Created by Ahmad Ragab on 19/06/2025.
//

import SwiftUI

struct AsyncImageView: View {
    let url: String
    @State private var image: UIImage?
    @State private var isLoading = true
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if isLoading {
                ProgressView()
                    .scaleEffect(0.8)
            } else {
                Image(systemName: "photo")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        // Use URLSession with caching
        ImageCache.shared.loadImage(from: url) { result in
            DispatchQueue.main.async {
                isLoading = false
                if case .success(let loadedImage) = result {
                    image = loadedImage
                }
            }
        }
    }
}
