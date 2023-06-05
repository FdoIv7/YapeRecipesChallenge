//
//  ImageLoader.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 31/05/23.
//

import UIKit
import SwiftUI

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false

    var imageCache = _imageCache

    func loadImage(with url: URL) async throws {
        let urlString = url.absoluteString
        if let imageFromCache = self.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            await MainActor.run {
                self.image = imageFromCache
            }
            return
        }

        do {
            let data = try Data(contentsOf: url)
            guard let image = UIImage(data: data) else { return }
            self.imageCache.setObject(image, forKey: urlString as AnyObject)
            await MainActor.run {
                self.image = image
            }
        } catch {
            throw ImageLoaderError.loadingError
        }
        
    }
}

enum ImageLoaderError: Error {
    case loadingError

    var localizedDescription: String {
        switch self {
        case .loadingError: return "Error loading the image"
        }
    }
}
