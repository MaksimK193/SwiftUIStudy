//
//  ContentCoordinator.swift
//  SwiftUIStudy
//
//  Created by USER on 30.11.2023.
//

import Foundation
import SwiftUI
import Stinsen

final class ContentCoordinator: NavigationCoordinatable {
    let localNotificationManager: LocalNotificationManager
    let getStreamManager: GetStreamManager
    let languageManager: LanguageManager
    let stack = NavigationStack(initial: \ContentCoordinator.start)
    
    @Root var start = makeStart
    @Route(.push) var swiftData = makeSwiftData
    @Route(.push) var coreData = makeCoreData
    @Route(.push) var weather = makeWeather
    @Route(.push) var photoCompression = makePhotoCompression
    @Route(.push) var liveActivity = makeLiveActivity
    @Route(.push) var scheduleNotification = makeScheduleNotification
    @Route(.push) var getStreamChat = makeGetStreamChat
    @Route(.push) var geoTrack = makeGeoTrack
    @Route(.push) var changeLanguage = makeChangeLanguage
    
    init(localNotificationManager: LocalNotificationManager,
         getStreamManager: GetStreamManager,
         languageManager: LanguageManager) {
        self.localNotificationManager = localNotificationManager
        self.getStreamManager = getStreamManager
        self.languageManager = languageManager
    }
}

extension ContentCoordinator {
    @ViewBuilder func makeCoreData(stateManager: AppStateManager) -> some View {
        CoreDataView(stateManager: stateManager)
    }
    
    @ViewBuilder func makeSwiftData(stateManager: AppStateManager) -> some View {
        SwiftDataView(stateManager: stateManager)
    }
    
    @ViewBuilder func makeWeather(stateManager: AppStateManager) -> some View {
        WeatherView(stateManager: stateManager)
    }
    
    @ViewBuilder func makePhotoCompression(stateManager: AppStateManager) -> some View {
        PhotoCompressionView(stateManager: stateManager)
    }
    
    @ViewBuilder func makeLiveActivity() -> some View {
        LiveActivityView()
    }
    
    @ViewBuilder func makeStart() -> some View {
        ContentView(stateManager: AppStateManager.shared)
    }
    
    @ViewBuilder func makeScheduleNotification() -> some View {
        ScheduleNotification(localNotificationManager: localNotificationManager)
    }
    
    @ViewBuilder func makeGetStreamChat() -> some View {
        GetStreamChatView(getStreamManager: getStreamManager)
    }
    
    @ViewBuilder func makeGeoTrack() -> some View {
        GeoTrackView()
    }
    
    @ViewBuilder func makeChangeLanguage() -> some View {
        ChangeLanguageView(languageManager: languageManager)
    }
}
