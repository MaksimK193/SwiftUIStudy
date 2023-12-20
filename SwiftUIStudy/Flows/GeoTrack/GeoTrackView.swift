//
//  GeoTrackView.swift
//  SwiftUIStudy
//
//  Created by USER on 18.12.2023.
//

import SwiftUI

struct GeoTrackView: View {
    @StateObject private var viewModel = GeoTrackViewModel()
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("Geo tracker")
            Button("Allow tracking") {
                showAlert.toggle()
            }
            .opacity((viewModel.locationStatus == .authorizedAlways || viewModel.locationStatus == .authorizedWhenInUse) ? 0 : 1)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Allow tracking"),
                  primaryButton: .default(Text("Go to settings"),
                                          action: {
                                              UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                          }),
                  secondaryButton: .default(Text("Cancel")))
        }
    }
}

#Preview {
    GeoTrackView()
}
