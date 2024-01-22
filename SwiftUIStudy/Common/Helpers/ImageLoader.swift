//
//  ImageLoader.swift
//  SwiftUIStudy
//
//  Created by USER on 18.01.2024.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false

    private var cancellable: AnyCancellable?

    func load(fromURLString urlString: String) {
        if let cachedImage = ImageCache.shared.getImage(forKey: urlString) {
            self.image = cachedImage
            return
        }

        guard let url = URL(string: urlString) else { return }

        isLoading = true

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                if let image = $0 {
                    ImageCache.shared.setImage(image, forKey: urlString)
                }
                self?.image = $0
                self?.isLoading = false
            } 
    }
    
    deinit {
        cancellable?.cancel()
    }
}

class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSString, UIImage>()

    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }

    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
}
