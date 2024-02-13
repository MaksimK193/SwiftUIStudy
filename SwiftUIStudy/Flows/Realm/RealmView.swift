//
//  RealmView.swift
//  SwiftUIStudy
//
//  Created by USER on 13.02.2024.
//

import SwiftUI
import YandexMobileMetrica

struct RealmView: View {
    var body: some View {
        Text("Realm")
            .onAppear {
                YMMYandexMetrica.reportEvent("RealmScreen opened")
            }
    }
}

#Preview {
    RealmView()
}
