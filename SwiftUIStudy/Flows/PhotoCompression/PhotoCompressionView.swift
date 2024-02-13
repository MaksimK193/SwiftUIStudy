//
//  PhotoCompressionView.swift
//  SwiftUIStudy
//
//  Created by USER on 28.11.2023.
//

import SwiftUI
import YandexMobileMetrica

struct PhotoCompressionView: View {
    @State var imageData: UIImage = UIImage()
    @State var compressedImage: Data = .init()
    @State var show = true
    @State var imagepicker = false
    @ObservedObject var stateManager: AppStateManager
    
    var body: some View {
        ZStack {
            VStack() {
                images
                NavigationLink(L10n.PhotoCompression.Button.takePhoto) {
                    CameraViewController(image: $imageData)
                }
                Button(L10n.PhotoCompression.Button.compressPhoto) {
                    compressedImage = imageData.jpegData(compressionQuality: 0.9) ?? .init()
                }
                .accessibilityIdentifier("compressPhotoButton")
                Spacer()
            }
            InactiveView()
                .opacity(stateManager.isActive ? 0 : 100)
        }
        .onAppear {
            YMMYandexMetrica.reportEvent("PhotoCompressionScreen opened")
        }
    }
    
    var images: some View {
        VStack {
            HStack {
                if imageData == UIImage() {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .opacity(0.6)
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                } else {
                    Image(uiImage: imageData)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                }
                Spacer()
                Text(convertFromBToMB(imageData.pngData()?.count))
            }
            .padding()
            HStack() {
                if compressedImage.count == 0 {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .opacity(0.6)
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                } else {
                    Image(uiImage: UIImage(data: compressedImage)!)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                }
                Spacer()
                Text(convertFromBToMB(compressedImage.count))
            }
            .padding()
        }
    }
    
    func convertFromBToMB(_ bytes: Int?) -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB]
        bcf.countStyle = .file
        guard let bytes = bytes else { return bcf.string(fromByteCount: 0) }
        let mb = bcf.string(fromByteCount: Int64(bytes))
        return mb
    }
}

#Preview("PhotoCompressionView") {
    PhotoCompressionView(stateManager: AppStateManager.shared)
}

