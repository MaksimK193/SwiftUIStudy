//
//  CarouselListView.swift
//  SwiftUIStudy
//
//  Created by USER on 25.12.2023.
//

import SwiftUI
import YandexMobileMetrica

struct CarouselListView: View {
    var body: some View {
        List() {
            ForEach(0..<10) { page in
                NavigationLink("\(page)", destination: CarouselView(viewModel: CarouselViewModel(selectedPage: page)))
            }
        }
        .onAppear {
            YMMYandexMetrica.reportEvent("CarouselListScreen opened")
        }
    }
}

#Preview {
    NavigationStack() {
        CarouselListView()
    }
}
