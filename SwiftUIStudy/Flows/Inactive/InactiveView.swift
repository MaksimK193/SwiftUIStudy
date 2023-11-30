//
//  InactiveView.swift
//  SwiftUIStudy
//
//  Created by USER on 28.11.2023.
//

import SwiftUI

struct InactiveView: View {
    var body: some View {
        ZStack {
            Color(.white)
            Text("SwiftUIStudy")
                .fontWeight(.ultraLight)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    InactiveView()
}
