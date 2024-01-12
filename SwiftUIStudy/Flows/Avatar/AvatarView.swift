//
//  AvatarView.swift
//  SwiftUIStudy
//
//  Created by USER on 12.01.2024.
//

import SwiftUI

struct AvatarView: View {
    @State private var inputText: String = ""
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        TextField("", text: $inputText)
    }
}

#Preview {
    AvatarView()
}
