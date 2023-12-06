//
//  SwiftUIStudyTests.swift
//  SwiftUIStudyTests
//
//  Created by USER on 15.11.2023.
//

import XCTest

final class SwiftUIStudyTests: XCTestCase {

    func test_byteConvertion_with1048576_should1MB() {
        let comprView = PhotoCompressionView(stateManager: AppStateManager.shared)
        
        let actual = comprView.convertFromBToMB(1_048_576)
        let expected = "1 MB"
        
        XCTAssertEqual(actual, expected)
    }

}
