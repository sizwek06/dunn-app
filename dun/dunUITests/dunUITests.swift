//
//  dunUITests.swift
//  dunUITests
//
//  Created by Sizwe Khathi on 2025/05/03.
//

import XCTest
import CloudKit
import SwiftUICore

final class dunUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testLaunch() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func testError() {
        // Given
        @State var bool = true
        @Environment(\.dismiss) var dismiss
        
        // When
        let sut = ErrorView(isPresented: $bool,
                            dismiss: _dismiss,
                            errorTitle: "Error: Unit Tests",
                            errorDescription: "Tesing Unit Tests")
        
        // Then
        XCTAssertEqual(sut.isPresented, true)
        XCTAssertEqual(sut.errorTitle, "Error: Unit Tests")
        XCTAssertEqual(sut.errorDescription, "Tesing Unit Tests")
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
