//
//  ChangeLanguageView.swift
//  SwiftUIStudy
//
//  Created by USER on 21.12.2023.
//

import SwiftUI

struct ChangeLanguageView: View {
    @State private var language = UserDefaults.standard.value(forKey: "language") as? String ?? "Ru"
    private var languages = ["Ru", "En"]
    
    var body: some View {
        Picker("Lang", selection: $language) {
            ForEach(languages, id: \.self) { language in
                Text(language)
            }
        }
        .onChange(of: language) { lang in
            if lang == "En" {
                UserDefaults.standard.setValue("En", forKeyPath: "language")
                L10n.bundle = Bundle(path: Bundle.main.path(forResource: "en", ofType: "lproj")!)
            } else {
                UserDefaults.standard.setValue("Ru", forKeyPath: "language")
                L10n.bundle = Bundle(path: Bundle.main.path(forResource: "ru", ofType: "lproj")!)
            }
        }
        .pickerStyle(.segmented)
        .frame(maxWidth: 200)
    }
}

#Preview {
    ChangeLanguageView()
}
