//
//  CarouselListView.swift
//  SwiftUIStudy
//
//  Created by USER on 25.12.2023.
//

import SwiftUI

struct CarouselListView: View {
    var body: some View {
        List() {
            ForEach(0..<10) { _ in
                NavigationLink("123", destination: CarouselView())
            }
        }
    }
}

#Preview {
    NavigationStack() {
        CarouselListView()
    }
}
