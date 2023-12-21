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
            Color.white
            Text(L10n.Inactive.Label.appName)
                .fontWeight(.ultraLight)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    InactiveView()
}
