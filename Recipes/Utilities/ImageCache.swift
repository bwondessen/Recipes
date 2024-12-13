//
//  ImageCache.swift
//  Recipes
//
//  Created by Bruke Wondessen on 12/11/24.
//

import Foundation
import SwiftUI
import Combine

class ImageCache {
    static let shared = ImageCache()
    
    private var memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    private init() {
        cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("ImageCache", isDirectory: true)
        
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
        }
    }
    
    func cachedImage(forKey key: String) -> UIImage? {
        if let cachedImage = memoryCache.object(forKey: key as NSString) {
            return cachedImage
        }
        
        let fileURL = cacheDirectory.appendingPathComponent(key)
        if let imageData = try? Data(contentsOf: fileURL), let image = UIImage(data: imageData) {
            // Store the image in memory cache
            memoryCache.setObject(image, forKey: key as NSString)
            return image
        }
        
        return nil
    }
    
    func saveImageToCache(_ image: UIImage, forKey key: String) {
        memoryCache.setObject(image, forKey: key as NSString)
        
        let fileURL = cacheDirectory.appendingPathComponent(key)
        if let data = image.pngData() {
            try? data.write(to: fileURL)
        }
    }
}
