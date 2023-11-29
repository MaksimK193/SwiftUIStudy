//
//  PhotoCompressionView.swift
//  SwiftUIStudy
//
//  Created by USER on 28.11.2023.
//

import SwiftUI

struct PhotoCompressionView: View {
    @State var imageData: Data = .init(capacity: 0)
    @State var compressedImage: Data = .init(capacity: 0)
    @State var show = true
    @State var imagepicker = false
    
    var body: some View {
        VStack() {
            if imageData.count != 0 {
                HStack {
                    Image(uiImage: UIImage(data: imageData)!)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                    Spacer()
                    Text("\(self.imageData.count)")
                }
                .padding()
                HStack() {
                    Image(uiImage: UIImage(data: compressedImage) ?? UIImage(systemName: "photo.fill")!)
                        .resizable()
                        .scaledToFit()
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 200)
                    if let compressedImage = UIImage(data: compressedImage) {
                        Spacer()
                        Text("\(compressedImage.jpegData(compressionQuality: 0.5)!.count)")
                    }
                }
                .padding()
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.6)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.horizontal)
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.6)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.horizontal)
            }
            NavigationLink {
                ImagePicker(show: $imagepicker, image: $imageData, source: .camera)
            } label: {
                Text("Take photo")
            }
            Button("Compress photo") {
                compressedImage = UIImage(data: imageData)?.jpegData(compressionQuality: 0.5) ?? .init()
            }
            Spacer()
        }
    }
}

#Preview {
    PhotoCompressionView()
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var show: Bool
    @Binding var image: Data
    var source: UIImagePickerController.SourceType
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePicker.Coordinator(parent1: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = source
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(parent1: ImagePicker) {
            parent = parent1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as! UIImage
            let data = image.pngData()
            self.parent.image = data!
            self.parent.show.toggle()
        }
    }
}

