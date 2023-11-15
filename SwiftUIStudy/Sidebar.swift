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
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        isSidebarOpened.toggle()
                    }
                }
            }
        
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.2))
            .opacity(isSidebarOpened ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: isSidebarOpened)
            .onTapGesture {
                isSidebarOpened.toggle()
            }
            content
                .gesture(drag)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        HStack {
            ZStack {
                Color.white
                    .frame(width: sidebarWidth)
                List() {
                    ForEach(1..<25) { item in
                        NavigationLink(destination: NewTaskView(text: "\(item)")) {
                            Text("\(item)")
                        }
                    }
                }
                .listStyle(.plain)
                .padding([.top], 60)
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
        ContentView()
    }
}
