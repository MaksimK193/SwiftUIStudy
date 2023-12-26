//
//  CarouselPageView.swift
//  SwiftUIStudy
//
//  Created by USER on 26.12.2023.
//

import Foundation
import SwiftUI

struct CarouselPageView: View {
    @State var pageNumber: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack() {
                Spacer()
                Text(pageNumber)
                    .background(.orange)
                    .font(.title)
                Spacer()
            }
            Spacer()
        }
    }
}
