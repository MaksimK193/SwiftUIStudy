//
//  SidebarViewModel.swift
//  SwiftUIStudy
//
//  Created by USER on 16.11.2023.
//

import Foundation

enum TaskScreens: String {
    case coreData
    case swiftData
    case weather
    case photoCompression
    case liveActivity
    case scheduleNotification
    case getStreamChat
    case geoTrack
    case changeLanguage
    case carousel
    case notificationActions
    case avatar
    case countries
    case yandexMaps
    case realm
    
    case exit
    
    func screenTitle() -> String {
        switch self {
        case .coreData:
            return L10n.Sidebar.NavigationRow.coreData
        case .swiftData:
            return L10n.Sidebar.NavigationRow.swiftData
        case .weather:
            return L10n.Sidebar.NavigationRow.weather
        case .photoCompression:
            return L10n.Sidebar.NavigationRow.photoCompression
        case .liveActivity:
            return L10n.Sidebar.NavigationRow.liveActivity
        case .scheduleNotification:
            return L10n.Sidebar.NavigationRow.scheduleNotification
        case .getStreamChat:
            return L10n.Sidebar.NavigationRow.getStreamChat
        case .geoTrack:
            return  L10n.Sidebar.NavigationRow.geoTrack
        case .changeLanguage:
            return L10n.Sidebar.NavigationRow.changeLanguage
        case .carousel:
            return L10n.Sidebar.NavigationRow.carousel
        case .notificationActions:
            return L10n.Sidebar.NavigationRow.notificationActions
        case .exit:
            return L10n.Sidebar.NavigationRow.exit
        case .avatar:
            return L10n.Sidebar.NavigationRow.avatar
        case .countries:
            return L10n.Sidebar.NavigationRow.countries
        case .yandexMaps:
            return L10n.Sidebar.NavigationRow.yandexMaps
        case .realm:
            return L10n.Sidebar.NavigationRow.realm
        }
    }
}

class SidebarViewModel: ObservableObject {
    @Published var screens: [SidebarListModel] = [SidebarListModel(id: 0, screen: .coreData),
                                                  SidebarListModel(id: 1, screen: .swiftData),
                                                  SidebarListModel(id: 2, screen: .realm),
                                                  SidebarListModel(id: 3, screen: .weather),
                                                  SidebarListModel(id: 4, screen: .photoCompression),
                                                  SidebarListModel(id: 5, screen: .liveActivity),
                                                  SidebarListModel(id: 6, screen: .scheduleNotification),
                                                  SidebarListModel(id: 7, screen: .getStreamChat),
                                                  SidebarListModel(id: 8, screen: .geoTrack),
                                                  SidebarListModel(id: 9, screen: .changeLanguage),
                                                  SidebarListModel(id: 10, screen: .carousel),
                                                  SidebarListModel(id: 12, screen: .notificationActions),
                                                  SidebarListModel(id: 13, screen: .avatar),
                                                  SidebarListModel(id: 14, screen: .countries),
                                                  SidebarListModel(id: 15, screen: .yandexMaps),
                                                  
                                                  SidebarListModel(id: 11, screen: .exit)]
}
