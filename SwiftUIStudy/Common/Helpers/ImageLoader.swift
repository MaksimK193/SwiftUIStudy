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
        guard let url = URL(string: urlString) else {
            return
        }

        isLoading = true

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.image = $0
                self?.isLoading = false
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
