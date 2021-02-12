//
//  TabBarViewModelTests.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 09/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import XCTest
@testable import TheUniverse

class TabBarViewModelTests: XCTestCase {

    func test_getInformationsFromCelestialBody_forIndexZero_returnNinePlanets() {
        //Given
        let sut = TabBarViewModel()

        //When
        let tupleForPlanets = sut.getInformationsFromCelestialBody(indexOf: 0)

        //Then
        XCTAssertEqual(tupleForPlanets.0.count, 9)
    }

    func test_getInformationsFromCelestialBody_forIndexNonexistent_returnEmptyTuple() {
        //Given
        let sut = TabBarViewModel()

        //When
        let tupleForPlanets = sut.getInformationsFromCelestialBody(indexOf: 3)

        //Then
        XCTAssertEqual(tupleForPlanets.0.count, 0)
    }

}
