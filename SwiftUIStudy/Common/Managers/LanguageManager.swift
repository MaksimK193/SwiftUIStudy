//
//  LanguageManager.swift
//  SwiftUIStudy
//
//  Created by USER on 22.12.2023.
//

import Foundation

enum LocalizationLanguage: String {
    case ru = "ru"
    case en = "en"
    
    var name: String {
        switch self {
        case .ru:
            return "Ru"
        case .en:
            return "En"
        }
    }
    
    var forResource: String {
        switch self {
        case .ru:
            return "ru"
        case .en:
            return "en"
        }
    }
}

class LanguageManager {
    func setDefaultLanguage() {
        guard let language = UserDefaults.standard.string(forKey: "language") else { return }
        let _language = LocalizationLanguage(rawValue: language) ?? .ru
        L10n.bundle = Bundle(path: Bundle.main.path(forResource: _language.forResource, ofType: "lproj")!)
    }
    
    func changeAppLanguage(_ language: LocalizationLanguage) {
        UserDefaults.standard.setValue(language.rawValue, forKeyPath: "language")
        L10n.bundle = Bundle(path: Bundle.main.path(forResource: language.forResource, ofType: "lproj")!)
    }
}
