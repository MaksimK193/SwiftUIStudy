//
//  CarouselViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 26.12.2023.
//

import Foundation

class CarouselViewModel: ObservableObject {
    @Published var selectedPage: Int
    init(selectedPage: Int) {
        self.selectedPage = selectedPage
    }
}
