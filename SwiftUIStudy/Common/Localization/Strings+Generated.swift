// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Content {
    internal enum Label {
      /// Hello world
      internal static let helloWolrd = L10n.tr("Localizable", "content.label.helloWolrd", fallback: "Hello world")
    }
  }
  internal enum CoreData {
    internal enum Button {
      /// Add departments
      internal static let addDepartments = L10n.tr("Localizable", "coreData.button.addDepartments", fallback: "Add departments")
      /// Add employee
      internal static let addEmployee = L10n.tr("Localizable", "coreData.button.addEmployee", fallback: "Add employee")
    }
  }
  internal enum GeoTrack {
    internal enum Alert {
      /// Cancel
      internal static let cancelButton = L10n.tr("Localizable", "geoTrack.alert.cancelButton", fallback: "Cancel")
      /// Go to settings
      internal static let settingsButton = L10n.tr("Localizable", "geoTrack.alert.settingsButton", fallback: "Go to settings")
      /// Allow tracking
      internal static let title = L10n.tr("Localizable", "geoTrack.alert.title", fallback: "Allow tracking")
    }
    internal enum Button {
      /// Allow tracking
      internal static let allowTracking = L10n.tr("Localizable", "geoTrack.button.allowTracking", fallback: "Allow tracking")
    }
    internal enum Label {
      /// Geo tracker
      internal static let geoTracker = L10n.tr("Localizable", "geoTrack.label.geoTracker", fallback: "Geo tracker")
    }
  }
  internal enum Inactive {
    internal enum Label {
      /// Localizable.strings
      ///   SwiftUIStudy
      /// 
      ///   Created by USER on 21.12.2023.
      internal static let appName = L10n.tr("Localizable", "inactive.label.appName", fallback: "SwiftUIStudy")
    }
  }
  internal enum LiveActivity {
    internal enum ActivityStatus {
      /// Accepted
      internal static let accepted = L10n.tr("Localizable", "liveActivity.activityStatus.accepted", fallback: "Accepted")
      /// Cook
      internal static let cook = L10n.tr("Localizable", "liveActivity.activityStatus.cook", fallback: "Cook")
      /// Deliver
      internal static let deliver = L10n.tr("Localizable", "liveActivity.activityStatus.deliver", fallback: "Deliver")
      /// Finished
      internal static let finished = L10n.tr("Localizable", "liveActivity.activityStatus.finished", fallback: "Finished")
    }
    internal enum Button {
      /// Cook
      internal static let cook = L10n.tr("Localizable", "liveActivity.button.cook", fallback: "Cook")
      /// Deliver
      internal static let deliver = L10n.tr("Localizable", "liveActivity.button.deliver", fallback: "Deliver")
      /// Finished
      internal static let finished = L10n.tr("Localizable", "liveActivity.button.finished", fallback: "Finished")
      /// Start activity
      internal static let startActivity = L10n.tr("Localizable", "liveActivity.button.startActivity", fallback: "Start activity")
    }
    internal enum Label {
      /// Live activity
      internal static let liveActivity = L10n.tr("Localizable", "liveActivity.label.liveActivity", fallback: "Live activity")
    }
  }
  internal enum PhotoCompression {
    internal enum Button {
      /// Compress photo
      internal static let compressPhoto = L10n.tr("Localizable", "photoCompression.button.compressPhoto", fallback: "Compress photo")
      /// Take photo
      internal static let takePhoto = L10n.tr("Localizable", "photoCompression.button.takePhoto", fallback: "Take photo")
    }
  }
  internal enum ScheduleNotification {
    internal enum Button {
      /// Schedule notification
      internal static let scheduleNotification = L10n.tr("Localizable", "scheduleNotification.button.scheduleNotification", fallback: "Schedule notification")
    }
    internal enum TextField {
      /// Notification text
      internal static let notificationText = L10n.tr("Localizable", "scheduleNotification.textField.notificationText", fallback: "Notification text")
    }
  }
  internal enum Sidebar {
    internal enum NavigationRow {
      /// Core Data
      internal static let coreData = L10n.tr("Localizable", "sidebar.navigationRow.coreData", fallback: "Core Data")
      /// Geo Track
      internal static let geoTrack = L10n.tr("Localizable", "sidebar.navigationRow.geoTrack", fallback: "Geo Track")
      /// Get Stream Chat
      internal static let getStreamChat = L10n.tr("Localizable", "sidebar.navigationRow.getStreamChat", fallback: "Get Stream Chat")
      /// Live Activity
      internal static let liveActivity = L10n.tr("Localizable", "sidebar.navigationRow.liveActivity", fallback: "Live Activity")
      /// Photo Compression
      internal static let photoCompression = L10n.tr("Localizable", "sidebar.navigationRow.photoCompression", fallback: "Photo Compression")
      /// Schedule Notification
      internal static let scheduleNotification = L10n.tr("Localizable", "sidebar.navigationRow.scheduleNotification", fallback: "Schedule Notification")
      /// Swift Data
      internal static let swiftData = L10n.tr("Localizable", "sidebar.navigationRow.swiftData", fallback: "Swift Data")
      /// Weather
      internal static let weather = L10n.tr("Localizable", "sidebar.navigationRow.weather", fallback: "Weather")
    }
  }
  internal enum SwiftData {
    internal enum Button {
      /// Add item
      internal static let addItem = L10n.tr("Localizable", "swiftData.button.addItem", fallback: "Add item")
    }
    internal enum TextField {
      /// id
      internal static let id = L10n.tr("Localizable", "swiftData.textField.id", fallback: "id")
      /// name
      internal static let name = L10n.tr("Localizable", "swiftData.textField.name", fallback: "name")
    }
  }
  internal enum Weather {
    internal enum Button {
      /// Update
      internal static let update = L10n.tr("Localizable", "weather.button.update", fallback: "Update")
    }
    internal enum Label {
      /// Temperature %@ degrees
      internal static func temperature(_ p1: Any) -> String {
        return L10n.tr("Localizable", "weather.label.temperature", String(describing: p1), fallback: "Temperature %@ degrees")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
