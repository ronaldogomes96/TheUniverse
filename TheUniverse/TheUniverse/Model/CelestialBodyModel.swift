//
//  CelestialBodyModel.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 16/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation

enum ListOfCelestialBodyType: String {
    case planets
    case satellites
    case stars
}

class CelestialBodyModel {

    func getListOfNamesAndImagesOfCelestialBody(from celestialBodyType: ListOfCelestialBodyType) -> ([String], [String])? {

        let celestialBodyData = getCelestialBodyFromJson()
        let celestialBodyName: [String]
        let celestialBodyImageName: [String]

        switch celestialBodyType {
        case .planets:
            celestialBodyName = celestialBodyData!.planets.name
            celestialBodyImageName = celestialBodyData!.planets.image
        case .satellites:
            celestialBodyName = celestialBodyData!.satellites.name
            celestialBodyImageName = celestialBodyData!.satellites.image
        case .stars:
            celestialBodyName = celestialBodyData!.stars.name
            celestialBodyImageName = celestialBodyData!.stars.image
        }

        return (celestialBodyName, celestialBodyImageName)
    }

    func getCelestialBodyFromJson() -> CelestialBody? {

        let filePathUrl = Bundle.main.url(forResource: "celestialBody", withExtension: "json")!
        let jsonData = try? Data(contentsOf: filePathUrl)
        guard let data = jsonData else {
            return nil
        }
        let celestialBody: CelestialBody
        do {
            celestialBody = try JSONDecoder().decode(CelestialBody.self, from: data)
        } catch {
            print(error)
            return nil
        }
        return celestialBody
    }

    func getCelestialBodyDescription(celestialBody: String) -> CelestialBodyDescription? {

        let celestialBodyName = CelestialBodyNames(rawValue: celestialBody)?.englishNameOfCelestialBody
        let celestialBodyDescriptionFromJson = getCelestialBodyDescriptionFromJson(jsonName: celestialBodyName!)

        return celestialBodyDescriptionFromJson ?? nil
    }

    func getCelestialBodyDescriptionFromJson(jsonName: String) -> CelestialBodyDescription? {

        let filePath = Bundle.main.url(forResource: jsonName, withExtension: "json")
        guard let fileUrlPath = filePath else {
            return nil
        }

        let jsonData = try? Data(contentsOf: fileUrlPath)
        guard let data = jsonData else {
            return nil
        }

        let celestialBodyDescription: CelestialBodyDescription
        do {
            celestialBodyDescription = try JSONDecoder().decode(CelestialBodyDescription.self, from: data)
        } catch {
            print(error)
            return nil
        }

        return celestialBodyDescription
    }
}
