//
//  CelestialBodyDataViewModelTests.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 09/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import XCTest
@testable import TheUniverse

class CelestialBodyDataViewModelTests: XCTestCase {

    func test_getCelestialBodyDescription_earthPlanet_returnsNotNil() {
        //Givem
        let sut = CelestialBodyDataViewModel(celestialBodyName: "Terra")

        //When
        let celestialBodyInformation = sut.getCelestialBodyDescription()

        //Then
        XCTAssertNotNil(celestialBodyInformation)
    }

    func test_getCelestialBodyDescription_nonexistentPlanet_returnsNil() {
        //Givem
        let sut = CelestialBodyDataViewModel(celestialBodyName: "")

        //When
        let celestialBodyInformation = sut.getCelestialBodyDescription()

        //Then
        XCTAssertNil(celestialBodyInformation)
    }

    func test_numberOfDescriptions_earthPlanet_returnsTenInfos() {
        //Givem
        let sut = CelestialBodyDataViewModel(celestialBodyName: "Terra")

        //When
        let numberOfCelestialBodyInfo = sut.numberOfDescriptions()

        //Then
        XCTAssertEqual(numberOfCelestialBodyInfo, 10)
    }

    func test_numberOfDescriptions_nonexistentPlanet_returnsNil() {
        //Givem
        let sut = CelestialBodyDataViewModel(celestialBodyName: "")

        //When
        let numberOfCelestialBodyInfo = sut.numberOfDescriptions()

        //Then
        XCTAssertNil(numberOfCelestialBodyInfo)
    }

    func test_getCelestialBodyName_earthPlanet_returnsTerra() {
        //Givem
        let sut = CelestialBodyDataViewModel(celestialBodyName: "Terra")

        //When
        let celestialBodyName = sut.getCelestialBodyName()

        //Then
        XCTAssertEqual(celestialBodyName, "Terra")
    }
}
