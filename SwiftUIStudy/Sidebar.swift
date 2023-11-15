//
//  SideBar.swift
//  SwiftUIStudy
//
//  Created by USER on 15.11.2023.
//

import SwiftUI

struct SidebarView: View {
    @Binding var isSidebarOpened: Bool
    var sidebarWidth = UIScreen.main.bounds.size.width * 0.8
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.7))
            .opacity(isSidebarOpened ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: isSidebarOpened)
            .onTapGesture {
                isSidebarOpened.toggle()
            }
            
            content
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        HStack {
            ZStack {
                Color.white
                    .frame(width: sidebarWidth)
                VStack {                    List() {
                        ForEach(1..<10) { item in
                            Text("\(item)")
                        }
                    }
                    .listStyle(.plain)
                }
            }
            
            .frame(width: sidebarWidth)
            .offset(x: isSidebarOpened ? 0 : -sidebarWidth)
            .animation(.default, value: isSidebarOpened)
            Spacer()
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
//        SidebarView(isSidebarVisible: true)
        ContentView()
    }
}
