//
//  CelestialBodyModelTests.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 16/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import XCTest
@testable import TheUniverse

class CelestialBodyModelTests: XCTestCase{

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_getListOfNamesAndImagesOfCelestialBody_celestialBodyData_returnsSatellitesNamesAndImages() {

        //Givem
        let celestialBody = CelestialBodyModel()
        let satellitesNames = ["Lua", "Fobos", "Titã", "Reia",
                               "Encelado", "Ganimedes", "Calisto",
                               "Io", "Titania", "Tritao", "Caronte"]
        let imageNames = ["Lua.jpg", "Fobos.jpg", "Titã.jpg",
                          "Reia.jpg", "Encelado.jpg", "Ganimedes.jpg",
                          "Calisto.jpg", "Io.jpg", "Titania.jpg",
                          "Tritao.jpg", "Caronte.jpg"]

        //When
        let satellitesNamesAndImages = (satellitesNames, imageNames)
        let listOfNamesAndImages = celestialBody.getListOfNamesAndImagesOfCelestialBody(from: "satellites")

        //Then
        XCTAssertEqual(satellitesNamesAndImages, listOfNamesAndImages!)

    }

    func test_getCelestialBodyFromJson_celestialBodyStruct_structNotNil() {

        //Given
        let celestialBody = CelestialBodyModel()

        //When
        let celestialBodyStruct = celestialBody.getCelestialBodyFromJson()

        //Then
        XCTAssertNotNil(celestialBodyStruct)
    }
}
