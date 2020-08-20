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
        let sut = CelestialBodyModel()
        let planetsNames = ["Mercúrio", "Vênus", "Terra",
                            "Marte", "Júpiter", "Saturno",
                            "Urano", "Neturno", "Plutão"]
        let imageNames = ["Mercurio.jpg", "Venus.jpg", "Terra.jpg",
                          "Marte.jpg", "Jupiter.jpg", "Saturno.jpg",
                          "Urano.jpg", "Neturno.jpg", "Plutao.jpg"]

        //When
        let listOfNamesAndImages = sut.getListOfNamesAndImagesOfCelestialBody(from: .planets)

        //Then
        XCTAssertEqual(planetsNames, listOfNamesAndImages?.0)
        XCTAssertEqual(imageNames, listOfNamesAndImages?.1)
    }

    func test_getListOfNamesAndImagesOfCelestialBody_celestialBodyData_returnsSatellitesNamesAndImages() {

        //Givem
        let sut = CelestialBodyModel()
        let satellitesNames = ["Lua", "Fobos", "Ganimedes", "Calisto",
                               "Io", "Titã", "Reia",
                               "Encélado", "Titânia", "Tritão", "Caronte"]
        let imageNames = ["Lua.jpg", "Fobos.jpg", "Ganimedes.jpg",
                                 "Calisto.jpg", "Io.jpg", "Tita.jpg",
                          "Reia.jpg", "Encelado.jpg", "Titania.jpg",
                          "Tritao.jpg", "Caronte.jpg"]

        //When
        let listOfNamesAndImages = sut.getListOfNamesAndImagesOfCelestialBody(from: .satellites)

        //Then
        XCTAssertEqual(satellitesNames, listOfNamesAndImages?.0)
        XCTAssertEqual(imageNames, listOfNamesAndImages?.1)
    }

    func test_getListOfNamesAndImagesOfCelestialBody_celestialBodyData_returnsStarsNamesAndImages() {

        //Givem
        let sut = CelestialBodyModel()
        let starsNames = ["Sol"]
        let imageNames = ["Sol.jpg"]

        //When
        let listOfNamesAndImages = sut.getListOfNamesAndImagesOfCelestialBody(from: .stars)

        //Then
        XCTAssertEqual(starsNames, listOfNamesAndImages?.0)
        XCTAssertEqual(imageNames, listOfNamesAndImages?.1)
    }

    func test_getCelestialBodyFromJson_celestialBodyStruct_structNotNil() {

        //Given
        let sut = CelestialBodyModel()

        //When
        let celestialBodyStruct = sut.getCelestialBodyFromJson()

        //Then
        XCTAssertNotNil(celestialBodyStruct)
    }
}
