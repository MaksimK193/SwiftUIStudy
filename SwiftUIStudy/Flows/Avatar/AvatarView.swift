//
//  AvatarView.swift
//  SwiftUIStudy
//
//  Created by USER on 12.01.2024.
//

import SwiftUI

struct AvatarView: View {
    @StateObject private var viewModel = AvatarViewModel()
    @State private var inputText: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("", text: $inputText)
                    .textFieldStyle(.roundedBorder)
                Button("", systemImage: "plus") {
                    viewModel.drawAvatar(hash: inputText.hashValue)
                }
            }
            .padding()
            Image(uiImage: viewModel.image)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.avatars) { avatar in
                        if let data = avatar.avatar {
                            Image(uiImage: UIImage(data: data) ?? UIImage())
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AvatarView()
}
