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
                        Task {
                            await loadImage()
                        }
                    }
            }
        }
    }
    
    private func loadImage() async {
        if let cachedImage = cache.cachedImage(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }
        
        isLoading = true
        await downloadImage()
    }
    
    private func downloadImage() async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let downloadedImage = UIImage(data: data) else {
                return
            }
            
            cache.saveImageToCache(downloadedImage, forKey: url.absoluteString)
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                self.image = downloadedImage
                self.isLoading = false
            }
        } catch {
            // Handle error (you can display an error image or message)
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}

#Preview {
    RecipeImageView(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9d257442-51c8-45c7-807a-e6132baa8fce/large.jpg")!)
}
