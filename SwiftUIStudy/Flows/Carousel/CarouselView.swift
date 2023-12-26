//
//  CarouselView.swift
//  SwiftUIStudy
//
//  Created by USER on 25.12.2023.
//

import SwiftUI

struct CarouselView: View {
    @ObservedObject var viewModel: CarouselViewModel
    @State private var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView(selection: $viewModel.selectedPage) {
            ForEach(0..<10) { item in
                GeometryReader { geo in
                    CarouselPageView(pageNumber: "\(item)")
                        .onChange(of: geo.frame(in: .global).minX) { value in
                            if value == 0 {
                                self.timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
                            } else {
                                timer.upstream.connect().cancel()
                            }
                        }
                }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .onReceive(timer, perform: { _ in
            if viewModel.selectedPage != 9 {
                withAnimation {
                    viewModel.selectedPage += 1
                }
            } else {
                viewModel.selectedPage = 0
            }
        })
    }
}

#Preview {
    CarouselView(viewModel: CarouselViewModel(selectedPage: 0))
}
