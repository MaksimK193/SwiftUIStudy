//
//  AppDelegate.swift
//  SwiftUIStudy
//
//  Created by USER on 24.01.2024.
//

import SwiftUI
import YandexMapsMobile

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        YMKMapKit.setApiKey("6baf250a-9db0-4cb1-967c-8000fbbad2a9")
        YMKMapKit.sharedInstance()
        return true
    }
    
}
