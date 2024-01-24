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
    
    var body: some View {
        ZStack {
            YandexMapView().edgesIgnoringSafeArea(.all).environmentObject(yandexLocationManager)
            VStack {
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
