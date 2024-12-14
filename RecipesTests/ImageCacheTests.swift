//
//  ImageCacheTests.swift
//  RecipesTests
//
//  Created by Bruke Wondessen on 12/13/24.
//

import XCTest
@testable import Recipes

final class ImageCacheTests: XCTestCase {
    private var imageCache: ImageCache!
    private var testImage: UIImage!
    private let testKey = "testKey"
    
    override func setUp() {
        super.setUp()
        imageCache = ImageCache.shared
        testImage = UIImage(systemName: "star.fill")
    }
    
    override func tearDown() {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("ImageCache", isDirectory: true)
        let fileURL = cacheDirectory.appendingPathComponent(testKey)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            try? fileManager.removeItem(at: fileURL)
        }
        
        testImage = nil
        super.tearDown()
    }
    
    func testSaveAndRetrieveImageFromMemoryCache() {
        imageCache.saveImageToCache(testImage, forKey: testKey)
        
        let cachedImage = imageCache.cachedImage(forKey: testKey)
        XCTAssertNotNil(cachedImage)
        XCTAssertEqual(cachedImage?.pngData(), testImage.pngData())
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
