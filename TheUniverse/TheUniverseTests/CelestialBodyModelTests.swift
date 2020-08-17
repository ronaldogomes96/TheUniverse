//
//  CelestialBodyModelTests.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 17/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import XCTest
@testable import TheUniverse

class CelestialBodyModelTests: XCTestCase {

    func test_getListOfNamesAndImagesOfCelestialBody_celestialBodyData_returnsPlanetsNamesAndImages() {

        //Givem
        let celestialBody = CelestialBodyModel()
        let planetsNames = ["Mercurio", "Venus", "Terra",
                            "Marte", "Saturno", "Jupiter",
                            "Urano", "Neturno", "Plutão"]
        let imageNames = ["Mercurio.jpg", "Venus.jpg", "Terra.jpg",
                          "Marte.jpg", "Saturno.jpg", "Jupiter.jpg",
                          "Urano.jpg", "Neturno.jpg", "Plutão.jpg"]

        //When
        let listOfNamesAndImages = celestialBody.getListOfNamesAndImagesOfCelestialBody(from: .planets)

        //Then
        XCTAssertEqual(planetsNames, listOfNamesAndImages?.0)
        XCTAssertEqual(imageNames, listOfNamesAndImages?.1)
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
        let listOfNamesAndImages = celestialBody.getListOfNamesAndImagesOfCelestialBody(from: .satellites)

        //Then
        XCTAssertEqual(satellitesNames, listOfNamesAndImages?.0)
        XCTAssertEqual(imageNames, listOfNamesAndImages?.1)
    }

    func test_getListOfNamesAndImagesOfCelestialBody_celestialBodyData_returnsStarsNamesAndImages() {

        //Givem
        let celestialBody = CelestialBodyModel()
        let starsNames = ["Sol"]
        let imageNames = ["Sol.jpg"]

        //When
        let listOfNamesAndImages = celestialBody.getListOfNamesAndImagesOfCelestialBody(from: .stars)

        //Then
        XCTAssertEqual(starsNames, listOfNamesAndImages?.0)
        XCTAssertEqual(imageNames, listOfNamesAndImages?.1)
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
