////
////  SwiftUIStudyUITests.swift
////  SwiftUIStudyUITests
////
////  Created by USER on 15.11.2023.
////
//
//import XCTest
//
//final class SwiftUIStudyUITests: XCTestCase {
//    var app: XCUIApplication!
//    
//    override func setUp() {
//        app = XCUIApplication()
//        app.launch()
//        
//        app.buttons["menuButton"].tap()
//    }
//
//    func test_navigation_shouldCorrectOpenView() {
//        let backButton = app.navigationBars.buttons.element(boundBy: 0)
//        
//        app.otherElements.buttons["Core Data"].tap()
//        XCTAssert(app.buttons["coreDataAddButton"].exists)
//        backButton.tap()
//        
//        app.otherElements.buttons["Swift Data"].tap()
//        XCTAssert(app.buttons["swiftDataAddButton"].exists)
//        backButton.tap()
//        
//        app.otherElements.buttons["Weather"].tap()
//        XCTAssert(app.buttons["weatherUpdateButton"].exists)
//        backButton.tap()
//        
//        app.otherElements.buttons["Photo Compression"].tap()
//        XCTAssert(app.buttons["compressPhotoButton"].exists)
//    }
//}
