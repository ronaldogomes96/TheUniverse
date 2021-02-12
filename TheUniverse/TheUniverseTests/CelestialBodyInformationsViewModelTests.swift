//
//  CelestialBodyInformationsViewModelTests.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 09/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
// swiftlint:disable line_length

import XCTest
@testable import TheUniverse

class CelestialBodyInformationsViewModelTests: XCTestCase {

    func test_getCelestialBodyDescriptionTittle_forEarthPlanetAndFirstIndex_returnsIntrodução() {
        //Given
        let sut = CelestialBodyInformationsViewModel(celestialBodyName: "Terra", indexPathForCell: 0)

        //When
        let celestialBodyDescriptionTittle = sut.getCelestialBodyDescriptionTittle()

        //Then
        XCTAssertEqual(celestialBodyDescriptionTittle, "Introdução")
    }

    func test_getCelestialBodyDescriptionTittle_noPlanet_returnsEmpty() {
        //Given
        let sut = CelestialBodyInformationsViewModel(celestialBodyName: "", indexPathForCell: 0)

        //When
        let celestialBodyDescriptionTittle = sut.getCelestialBodyDescriptionTittle()

        //Then
        XCTAssertEqual(celestialBodyDescriptionTittle, "")
    }

    func test_getCelestialBodyDescriptionString_forEarthPlanetAndFirstIndex_returnsDescriptionString() {
        //Given
        let sut = CelestialBodyInformationsViewModel(celestialBodyName: "Terra", indexPathForCell: 0)

        //When
        let celestialBodyDescription = sut.getCelestialBodyDescriptionString()

        //Then
        XCTAssertEqual(celestialBodyDescription, getDescriptionString())
    }

    func test_getCelestialBodyDescriptionString_noPlanet_returnsEmpty() {
        //Given
        let sut = CelestialBodyInformationsViewModel(celestialBodyName: "", indexPathForCell: 0)

        //When
        let celestialBodyDescription = sut.getCelestialBodyDescriptionString()

        //Then
        XCTAssertEqual(celestialBodyDescription, "")
    }

    // MARK: - Help Functions
    func getDescriptionString() -> String {
        return "Nosso planeta natal é o terceiro planeta do Sol, e o único lugar que conhecemos até agora que é habitado por seres vivos. Embora a Terra seja apenas o quinto maior planeta do sistema solar, é o único mundo em nosso sistema solar com água líquida na superfície. Um pouco maior que a vizinha Vênus, a Terra é o maior dos quatro planetas mais próximos do Sol, todos feitos de rocha e metal.\nO nome Terra tem pelo menos 1.000 anos. Todos os planetas, exceto a Terra, foram nomeados em homenagem a deuses e deusas gregos e romanos. No entanto, o nome Terra é uma palavra germânica, que significa simplesmente \"o solo\".\n"
    }
}
