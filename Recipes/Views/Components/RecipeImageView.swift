//
//  RecipeImageView.swift
//  Recipes
//
//  Created by Bruke Wondessen on 12/12/24.
//

import SwiftUI

struct RecipeImageView: View {
    let url: URL
    @State private var image: UIImage? = nil
    @State private var isLoading = false
    
    private let cache = ImageCache.shared
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }
    
    private func loadImage() {
        if let cachedImage = cache.cachedImage(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }
        
        isLoading = true
        downloadImage()
    }
    
    private func downloadImage() {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let downloadedImage = UIImage(data: data) else {
                return
            }
            
            cache.saveImageToCache(downloadedImage, forKey: url.absoluteString)
            
            DispatchQueue.main.async {
                self.image = downloadedImage
                self.isLoading = false
            }
        }
        
        task.resume()
    }
}

#Preview {
    RecipeImageView(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9d257442-51c8-45c7-807a-e6132baa8fce/large.jpg")!)
}
