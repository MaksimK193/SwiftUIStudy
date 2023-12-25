//
//  CarouselView.swift
//  SwiftUIStudy
//
//  Created by USER on 25.12.2023.
//

import SwiftUI

struct CarouselView: View {
        var body: some View {
            VStack(){
                TabView{
                    ForEach(0..<5) { item in
                        PageView()
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
        }
}

#Preview {
    CarouselView()
}

struct PageView: View {
    
    var body: some View {
        Text("123")
            .background(.orange)
            .font(.title)
    }
}
