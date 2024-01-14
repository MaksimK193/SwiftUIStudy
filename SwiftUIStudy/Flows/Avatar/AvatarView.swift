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
    @State private var image: UIImage = UIImage()
    
    var body: some View {
        VStack {
            HStack {
                TextField("", text: $inputText)
                    .textFieldStyle(.roundedBorder)
                Button("", systemImage: "plus") {
                    drawAvatar(bitMap: convertHashToBitMap(hash: inputText.hashValue))
                }
            }
            .padding()
            Image(uiImage: image)
            List {
                ForEach(viewModel.avatars) { avatar in
                    Text(avatar.id?.uuidString ?? "Unknown")
                }
            }
        }
    }
    
    func convertHashToBitMap(hash: Int) -> [Int]{
        let flatArray = Array(String(abs(hash)))
        
        return flatArray.flatMap {
            Int(String($0))
        }
    }
    
    func drawAvatar(bitMap: [Int]) {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 64, height: 64))
        
        let colors: [CGColor] = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.green.cgColor, UIColor.white.cgColor, UIColor.purple.cgColor, UIColor.gray.cgColor, UIColor.cyan.cgColor, UIColor.magenta.cgColor, UIColor.systemPink.cgColor, UIColor.orange.cgColor]

        let rectangles: [CGRect] = [
            CGRect(x: 0, y: 0, width: 16, height: 16), CGRect(x: 16, y: 0, width: 16, height: 16), CGRect(x: 32, y: 0, width: 16, height: 16), CGRect(x: 48, y: 0, width: 16, height: 16),
            CGRect(x: 0, y: 16, width: 16, height: 16), CGRect(x: 16, y: 16, width: 16, height: 16), CGRect(x: 32, y: 16, width: 16, height: 16), CGRect(x: 48, y: 16, width: 16, height: 16),
            CGRect(x: 0, y: 32, width: 16, height: 16), CGRect(x: 16, y: 32, width: 16, height: 16), CGRect(x: 32, y: 32, width: 16, height: 16), CGRect(x: 48, y: 32, width: 16, height: 16),
            CGRect(x: 0, y: 48, width: 16, height: 16), CGRect(x: 16, y: 48, width: 16, height: 16), CGRect(x: 32, y: 48, width: 16, height: 16), CGRect(x: 48, y: 48, width: 16, height: 16),
        ]
        
        let img = renderer.image { ctx in
            for (index, value) in rectangles.enumerated() {
                let rectangle = value
                ctx.cgContext.setFillColor(colors[bitMap[index]])
                ctx.cgContext.addRect(rectangle)
                ctx.cgContext.drawPath(using: .fill)
            }
        }

        image = img
    }
    
}

#Preview {
    AvatarView()
}
