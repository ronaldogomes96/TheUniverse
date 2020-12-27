//
//  CelestialBodyNamesTests.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 23/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import XCTest
@testable import TheUniverse

class CelestialBodyNamesTests: XCTestCase {

    func test_englishNameOfCelestialBody_translateNames_returnsCelestialBodyEnglish() {

        //Given
        let sut = CelestialBodyNames.self

        //When
        let listOfCelestialBodyPortuguese = ["Mercúrio", "Vênus", "Terra",
                                             "Marte", "Júpiter", "Saturno",
                                             "Urano", "Neturno", "Plutão",
                                             "Lua", "Fobos", "Ganimedes",
                                             "Calisto", "Io", "Titã", "Reia",
                                             "Encélado", "Titânia", "Tritão",
                                             "Caronte", "Sol"]
        let celestialBodyEnglish = ["mercury", "venus", "earth",
                                    "mars-planet", "jupiter", "saturn",
                                    "uranus", "neptune", "pluto",
                                    "moon", "phobos", "ganymede",
                                    "callisto", "io", "titan",
                                    "rhea", "enceladus", "titania",
                                    "triton", "charon", "sun"]
        var listOfCelestialBodyEnglish: [String] = []
        for index in 0..<listOfCelestialBodyPortuguese.count {
            listOfCelestialBodyEnglish.append(sut.init(rawValue:
                listOfCelestialBodyPortuguese[index])!.englishNameOfCelestialBody)
        }

        //Then
        XCTAssertEqual(listOfCelestialBodyEnglish, celestialBodyEnglish)
    }

}
