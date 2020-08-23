//
//  TheUniverseUITests.swift
//  TheUniverseUITests
//
//  Created by Ronaldo Gomes on 23/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import XCTest
@testable import TheUniverse

class FisrtPageUITests: XCTestCase {

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testFirstPageTabBar() {
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons["Satélites"].tap()
        tabBarsQuery.buttons["Estrelas"].tap()
        tabBarsQuery.buttons["Planetas"].tap()
    }
}
