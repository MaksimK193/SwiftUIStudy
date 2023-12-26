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
            ForEach(0..<10) { page in
                NavigationLink("\(page)", destination: CarouselView(viewModel: CarouselViewModel(selectedPage: page)))
            }
        }
    }
}

#Preview {
    NavigationStack() {
        CarouselListView()
    }
}
