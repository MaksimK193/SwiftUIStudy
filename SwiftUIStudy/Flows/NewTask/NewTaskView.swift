//
//  NewTaskView.swift
//  SwiftUIStudy
//
//  Created by USER on 15.11.2023.
//

import SwiftUI

struct NewTaskView: View {
    @State var text: String
    var body: some View {
        Color.white
            .navigationTitle(text)
    }
}
