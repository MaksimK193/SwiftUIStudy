//
//  ContentView.swift
//  SwiftUIStudy
//
//  Created by USER on 15.11.2023.
//

import SwiftUI
import Stinsen

struct ContentView: View {
    @State var isSideBarOpened = false
    @ObservedObject var stateManager: AppStateManager
    
    var body: some View {
        let drag = DragGesture()
            .onEnded { gesture in
                if gesture.location.x < 170 && gesture.translation.width > 30 {
                        isSideBarOpened.toggle()
                }
            }
        
        ZStack {
            NavigationView {
                Text("Hello world!")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading, content: { button })
                    }
            }
            SidebarView(stateManager: stateManager, isSidebarOpened: $isSideBarOpened)
            InactiveView()
                .opacity(stateManager.isActive ? 0 : 100)
        }
        .gesture(drag)
    }
    
    @ViewBuilder var button: some View {
        Button("", systemImage: "line.3.horizontal") {
            isSideBarOpened.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(stateManager: AppStateManager.shared)
    }
}
