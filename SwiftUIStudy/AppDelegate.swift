//
//  AppDelegate.swift
//  SwiftUIStudy
//
//  Created by USER on 24.01.2024.
//

import SwiftUI
import YandexMapsMobile
import YandexMobileMetrica

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        YMKMapKit.setApiKey("6baf250a-9db0-4cb1-967c-8000fbbad2a9")
        YMKMapKit.sharedInstance()
        
        let configuration = YMMYandexMetricaConfiguration.init(apiKey: "2aaf5ead-d4f4-4950-a5b6-4fa454505223")
        YMMYandexMetrica.activate(with: configuration!)
        return true
    }
}
