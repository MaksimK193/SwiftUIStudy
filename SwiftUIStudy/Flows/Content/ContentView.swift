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
                    withAnimation {
                        isSideBarOpened.toggle()
                    }
                }
            }
        
        ZStack {
            NavigationView {
                ZStack {
                    //                    NavigationStack {
                    Text("Hello world!")
                    
                    //                    }
                        .gesture(drag)
                    
                    
                }
                .navigationBarItems(leading: button)
            }
            SidebarView(isSidebarOpened: $isSideBarOpened)
            InactiveView()
                .opacity(stateManager.isActive ? 0 : 100 )
            
                
        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button("", systemImage: "line.3.horizontal") {
//                    isSideBarOpened.toggle()
//                }
//            }
//        }
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
