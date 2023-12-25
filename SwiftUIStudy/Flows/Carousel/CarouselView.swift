//
//  CarouselView.swift
//  SwiftUIStudy
//
//  Created by USER on 25.12.2023.
//

import SwiftUI

struct CarouselView: View {
    @State var selectedPage: Int = 0
    
    var body: some View {
        TabView(selection: $selectedPage) {
            ForEach(0..<10) { item in
                PageView(pageNumber: "\(item)")
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

#Preview {
    CarouselView()
}

struct PageView: View {
    @State var pageNumber: String
    
    var body: some View {
        Text(pageNumber)
            .background(.orange)
            .font(.title)
    }
}
