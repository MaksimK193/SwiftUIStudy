//
//  ChangeLanguageView.swift
//  SwiftUIStudy
//
//  Created by USER on 21.12.2023.
//

import SwiftUI
import YandexMobileMetrica

struct ChangeLanguageView: View {
    @State private var language: LocalizationLanguage
    private var languages = [LocalizationLanguage.ru, LocalizationLanguage.en]
    var languageManager: LanguageManager
    
    init(languageManager: LanguageManager) {
        self.languageManager = languageManager
        language = LocalizationLanguage(rawValue: UserDefaults.standard.value(forKey: "language") as? String ?? "ru") ?? .ru
    }
    
    var body: some View {
        Picker("Lang", selection: $language) {
            ForEach(languages, id: \.self) { language in
                Text(language.name)
            }
        }
        .onChange(of: language) { lang in
            languageManager.changeAppLanguage(lang)
        }
        .pickerStyle(.segmented)
        .frame(maxWidth: 200)
        .onAppear {
            YMMYandexMetrica.reportEvent("ChangeLanguageScreen opened")
        }
    }
}

#Preview {
    ChangeLanguageView(languageManager: LanguageManager())
}
