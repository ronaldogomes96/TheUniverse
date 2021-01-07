//
//  CelestialBodyModelTests.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 17/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
// swiftlint:disable line_length

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

    func test_getCelestialBodyDescription_marsDescriptionData_returnsMarsDescriptionIntroduction() {

        //Given
        let sut = CelestialBodyModel()

        //When
        let marsDescriptionFromJson = sut.getCelestialBodyDescription(celestialBody: "Marte")
        let marsDescription = getMarsDescription()

        //Then
        XCTAssertEqual(marsDescriptionFromJson?.info[0].description, marsDescription)
    }
    
    func test_getCelestialBodyDescription_celestialBodyNotExists_structNil() {

        //Given
        let sut = CelestialBodyModel()

        //When
        let celestialBodyDescriptionStruct = sut.getCelestialBodyDescription(celestialBody: "none")

        //then
        XCTAssertNil(celestialBodyDescriptionStruct)
    }

    func test_getCelestialBodyDescriptionFromJson_celestialBodyDescriptionStruct_structNotNil() {

        //Given
        let sut = CelestialBodyModel()

        //When
        let celestialBodyDescriptionStruct = sut.getCelestialBodyDescriptionFromJson(jsonName: "neptune")

        //then
        XCTAssertNotNil(celestialBodyDescriptionStruct)
    }

    func getMarsDescription() -> String {
        let mars =  "Marte foi batizado pelos antigos romanos em homenagem ao deus da guerra, porque sua cor avermelhada lembrava sangue. Outras civilizações também nomearam o planeta por este atributo; por exemplo, os egípcios o chamavam de \"Seu Desher\", que significa \"o vermelho\". Ainda hoje, é freqüentemente chamado de \"Planeta Vermelho\" porque os minerais de ferro da sujeira marciana se oxidam, ou enferrujam, fazendo com que a superfície pareça vermelha.\nNenhum planeta além da Terra foi estudado tão intensamente como Marte. As observações registradas de Marte datam da era do antigo Egito, há mais de 4.000 anos, quando mapearam os movimentos do planeta no céu. Hoje, uma frota científica de espaçonaves robóticas estuda Marte de todos os ângulos.\nSeis espaçonaves estão em órbita em Marte. O trio de cientistas da NASA são Mars Reconnaissance Orbiter, Mars Odyssey e MAVEN. A ESA geriu as missões ExoMars Trace Gas Orbiter e Mars Express. A primeira nave espacial Red Planet da Índia - a Mars Orbiter Mission (MOM) - desde 2014.\nDuas espaçonaves robóticas estão trabalhando na superfície. O rover Curiosity da NASA está explorando o Monte Sharp na cratera Gale. O InSight da NASA, um módulo de pouso estacionário, está sondando o interior de Marte de um local em uma planície lisa chamada Elysium Planitia.\nTanto a NASA quanto a ESA têm planos de enviar novos robôs a Marte em 2020.\n"

        return mars
    }
}
