//
//  YandexMapsView.swift
//  SwiftUIStudy
//
//  Created by USER on 24.01.2024.
//

import SwiftUI
import YandexMapsMobile

struct YandexMapsView: View {
    @ObservedObject var yandexLocationManager = YandexMapLocationManager()
    @State private var showAlert = false
    @State private var searchRequestText = ""
    
    var body: some View {
        ZStack {
            YandexMapView()
                .edgesIgnoringSafeArea(.all)
                .environmentObject(yandexLocationManager)
            VStack {
                TextField("Search", text: $searchRequestText) {
                    yandexLocationManager.search(withText: searchRequestText)
                }
                .textFieldStyle(.roundedBorder)
                .padding()
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        yandexLocationManager.currentUserLocation()
                    } label: {
                        Image(systemName: "location.circle")
                            .resizable()
                    }
                    .frame(width: 40,
                           height: 40)
                }
                .padding([.bottom], 60)
                .padding([.trailing], 16)
            }
        }
        .onAppear {
            yandexLocationManager.setupFirstLocation()
            showAlert = yandexLocationManager.shouldOnLocation
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(L10n.GeoTrack.Alert.title),
                  primaryButton: .default(Text(L10n.GeoTrack.Alert.settingsButton),
                                          action: {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }),
                  secondaryButton: .default(Text(L10n.YandexMap.Alert.cancelButton)))
        }
    }
}

#Preview {
    YandexMapsView()
}

struct YandexMapView: UIViewRepresentable {
    @EnvironmentObject var locationManager: YandexMapLocationManager
    
    func makeUIView(context: Context) -> YMKMapView {
        return locationManager.mapView
    }
    
    func updateUIView(_ uiView: YMKMapView, context: Context) { }
}
