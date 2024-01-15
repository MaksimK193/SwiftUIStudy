// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {

  /// Update bundle if you need to change app language
  static var bundle: Bundle?


  enum Auth {

  enum Alert {

  enum Title {
  /// Incorrect Face ID
  static var incorrectFaceID: String {
    return L10n.tr("Localizable", "auth.alert.title.incorrectFaceID")
  }
  /// Incorrect login or password
  static var incorrectPasswordOrLogin: String {
    return L10n.tr("Localizable", "auth.alert.title.incorrectPasswordOrLogin")
  }
  }
  }

  enum Button {
  /// FaceID
  static var faceID: String {
    return L10n.tr("Localizable", "auth.button.FaceID")
  }
  /// LogIn
  static var login: String {
    return L10n.tr("Localizable", "auth.button.login")
  }
  }

  enum TextField {
  /// Login
  static var login: String {
    return L10n.tr("Localizable", "auth.textField.login")
  }
  /// Password
  static var password: String {
    return L10n.tr("Localizable", "auth.textField.password")
  }
  }
  }

  enum Content {

  enum Label {
  /// Hello world
  static var helloWolrd: String {
    return L10n.tr("Localizable", "content.label.helloWolrd")
  }
  }
  }

  enum CoreData {

  enum Button {
  /// Add departments
  static var addDepartments: String {
    return L10n.tr("Localizable", "coreData.button.addDepartments")
  }
  /// Add employee
  static var addEmployee: String {
    return L10n.tr("Localizable", "coreData.button.addEmployee")
  }
  }
  }

  enum GeoTrack {

  enum Alert {
  /// Cancel
  static var cancelButton: String {
    return L10n.tr("Localizable", "geoTrack.alert.cancelButton")
  }
  /// Go to settings
  static var settingsButton: String {
    return L10n.tr("Localizable", "geoTrack.alert.settingsButton")
  }
  /// Allow tracking
  static var title: String {
    return L10n.tr("Localizable", "geoTrack.alert.title")
  }
  }

  enum Button {
  /// Allow tracking
  static var allowTracking: String {
    return L10n.tr("Localizable", "geoTrack.button.allowTracking")
  }
  }

  enum Label {
  /// Geo tracker
  static var geoTracker: String {
    return L10n.tr("Localizable", "geoTrack.label.geoTracker")
  }
  }
  }

  enum Inactive {

  enum Label {
  /// SwiftUIStudy
  static var appName: String {
    return L10n.tr("Localizable", "inactive.label.appName")
  }
  }
  }

  enum LiveActivity {

  enum ActivityStatus {
  /// Accepted
  static var accepted: String {
    return L10n.tr("Localizable", "liveActivity.activityStatus.accepted")
  }
  /// Cook
  static var cook: String {
    return L10n.tr("Localizable", "liveActivity.activityStatus.cook")
  }
  /// Deliver
  static var deliver: String {
    return L10n.tr("Localizable", "liveActivity.activityStatus.deliver")
  }
  /// Finished
  static var finished: String {
    return L10n.tr("Localizable", "liveActivity.activityStatus.finished")
  }
  }

  enum Button {
  /// Cook
  static var cook: String {
    return L10n.tr("Localizable", "liveActivity.button.cook")
  }
  /// Deliver
  static var deliver: String {
    return L10n.tr("Localizable", "liveActivity.button.deliver")
  }
  /// Finished
  static var finished: String {
    return L10n.tr("Localizable", "liveActivity.button.finished")
  }
  /// Start activity
  static var startActivity: String {
    return L10n.tr("Localizable", "liveActivity.button.startActivity")
  }
  }

  enum Label {
  /// Live activity
  static var liveActivity: String {
    return L10n.tr("Localizable", "liveActivity.label.liveActivity")
  }
  }
  }

  enum PhotoCompression {

  enum Button {
  /// Compress photo
  static var compressPhoto: String {
    return L10n.tr("Localizable", "photoCompression.button.compressPhoto")
  }
  /// Take photo
  static var takePhoto: String {
    return L10n.tr("Localizable", "photoCompression.button.takePhoto")
  }
  }
  }

  enum ScheduleNotification {

  enum Button {
  /// Schedule notification
  static var scheduleNotification: String {
    return L10n.tr("Localizable", "scheduleNotification.button.scheduleNotification")
  }
  }

  enum TextField {
  /// Notification text
  static var notificationText: String {
    return L10n.tr("Localizable", "scheduleNotification.textField.notificationText")
  }
  }
  }

  enum Sidebar {

  enum NavigationRow {
  /// Avatars
  static var avatar: String {
    return L10n.tr("Localizable", "sidebar.navigationRow.avatar")
  }
  /// Carousel
  static var carousel: String {
    return L10n.tr("Localizable", "sidebar.navigationRow.carousel")
  }
  /// Change language
  static var changeLanguage: String {
    return L10n.tr("Localizable", "sidebar.navigationRow.changeLanguage")
  }
  /// Core Data
  static var coreData: String {
    return L10n.tr("Localizable", "sidebar.navigationRow.coreData")
  }
  /// Exit
  static var exit: String {
    return L10n.tr("Localizable", "sidebar.navigationRow.exit")
  }
  /// Geo Track
  static var geoTrack: String {
    return L10n.tr("Localizable", "sidebar.navigationRow.geoTrack")
  }
  /// Get Stream Chat
  static var getStreamChat: String {
    return L10n.tr("Localizable", "sidebar.navigationRow.getStreamChat")
  }
  /// Live Activity
  static var liveActivity: String {
    return L10n.tr("Localizable", "sidebar.navigationRow.liveActivity")
  }
  /// Notification Actions
  static var notificationActions: String {
    return L10n.tr("Localizable", "sidebar.navigationRow.notificationActions")
  }
  /// Photo Compression
  static var photoCompression: String {
    return L10n.tr("Localizable", "sidebar.navigationRow.photoCompression")
  }
  /// Schedule Notification
  static var scheduleNotification: String {
    return L10n.tr("Localizable", "sidebar.navigationRow.scheduleNotification")
  }
  /// Swift Data
  static var swiftData: String {
    return L10n.tr("Localizable", "sidebar.navigationRow.swiftData")
  }
  /// Weather
  static var weather: String {
    return L10n.tr("Localizable", "sidebar.navigationRow.weather")
  }
  }
  }

  enum SwiftData {

  enum Button {
  /// Add item
  static var addItem: String {
    return L10n.tr("Localizable", "swiftData.button.addItem")
  }
  }

  enum TextField {
  /// id
  static var id: String {
    return L10n.tr("Localizable", "swiftData.textField.id")
  }
  /// name
  static var name: String {
    return L10n.tr("Localizable", "swiftData.textField.name")
  }
  }
  }

  enum Weather {

  enum Button {
  /// Update
  static var update: String {
    return L10n.tr("Localizable", "weather.button.update")
  }
  }

  enum Label {
  /// Temperature %@ degrees
  static func temperature(_ p1: String) -> String {
    return L10n.tr("Localizable", "weather.label.temperature",p1)
  }
  }
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: bundle ?? Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
