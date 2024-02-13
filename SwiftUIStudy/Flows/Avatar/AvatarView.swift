//
//  AvatarView.swift
//  SwiftUIStudy
//
//  Created by USER on 12.01.2024.
//

import SwiftUI
import YandexMobileMetrica

struct AvatarView: View {
    @StateObject private var viewModel = AvatarViewModel()
    @State private var inputText: String = ""
    @State private var scrollToEnd = false
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollProxy in
                HStack {
                    TextField("", text: $inputText)
                        .textFieldStyle(.roundedBorder)
                    Button("", systemImage: "plus") {
                        viewModel.drawAvatar(hash: inputText.hashValue)
                        scrollToEnd.toggle()
                    }
                }
                .padding()
                Image(uiImage: viewModel.image)
                ScrollView(.horizontal) {
                    ScrollViewReader { value in
                        HStack {
                            ForEach(viewModel.avatars) { avatar in
                                if let data = avatar.avatar {
                                    Image(uiImage: UIImage(data: data) ?? UIImage())
                                    
                                }
                            }
                            Spacer()
                                .id("last")
                        }
                        .onChange(of: scrollToEnd) { _ in
                            withAnimation {
                                value.scrollTo("last")
                            }
                        }
                    }
                    
                }
            }
        }
        .onAppear {
            YMMYandexMetrica.reportEvent("AvatarScreen opened")
        }
    }
}

#Preview {
    AvatarView()
}
