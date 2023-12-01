//
//  NewTaskView.swift
//  SwiftUIStudy
//
//  Created by USER on 15.11.2023.
//

import SwiftUI

struct NewTaskView: View {
    @State var text: String
    @ObservedObject var stateManager: AppStateManager
    
    var body: some View {
        ZStack {
            Color.white
                .navigationTitle(text)
            InactiveView()
                .opacity(stateManager.isActive ? 0 : 100)
        }
    }
}
