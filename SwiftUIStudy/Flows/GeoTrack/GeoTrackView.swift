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
            Text(L10n.GeoTrack.Label.geoTracker)
            Button(L10n.GeoTrack.Button.allowTracking) {
                showAlert.toggle()
            }
            .opacity((viewModel.locationStatus == .authorizedAlways || viewModel.locationStatus == .authorizedWhenInUse) ? 0 : 1)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(L10n.GeoTrack.Alert.title),
                  primaryButton: .default(Text(L10n.GeoTrack.Alert.settingsButton),
                                          action: {
                                              UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                          }),
                  secondaryButton: .default(Text(L10n.GeoTrack.Button.allowTracking)))
        }
    }
}

#Preview {
    GeoTrackView()
}
