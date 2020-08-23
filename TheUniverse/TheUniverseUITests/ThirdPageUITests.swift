//
//  ThirdPageUITests.swift
//  TheUniverseUITests
//
//  Created by Ronaldo Gomes on 23/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
// swiftlint:disable line_length

import XCTest
@testable import TheUniverse

class ThirdPageUITests: XCTestCase {

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testImageOfThirdPage() {
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Vênus"]/*[[".cells.staticTexts[\"Vênus\"]",".staticTexts[\"Vênus\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.otherElements.collectionViews.cells.children(matching: .other).element.tap()
    }
}
