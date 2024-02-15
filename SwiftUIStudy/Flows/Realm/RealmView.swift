//
//  RealmView.swift
//  SwiftUIStudy
//
//  Created by USER on 13.02.2024.
//

import SwiftUI
import RealmSwift
import YandexMobileMetrica

struct RealmView: View {
    @ObservedResults(Car.self) var cars
    @State var nameText: String = ""
    
    var body: some View {
        HStack {
            TextField("name", text: $nameText)
                .textFieldStyle(.roundedBorder)
            addButton
        }
        .padding()
        List {
            ForEach(cars) { item in
                Text(item.name)
            }
            .onDelete(perform: $cars.remove)
        }
        .onAppear {
            YMMYandexMetrica.reportEvent("RealmScreen opened")
        }
    }
    
    var addButton: some View {
        Button {
            withAnimation {
                $cars.append(Car(value: ["name": nameText]))
            }
        } label: {
            Image(systemName: "plus")
        }
    }
}

#Preview {
    RealmView()
}

