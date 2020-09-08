//
//  CelestialBodyModel.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 16/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation

enum ListOfCelestialBody: String {
    case planets
    case satellites
    case stars
}

class CelestialBodyModel {

    func getListOfNamesAndImagesOfCelestialBody(from celestialBodyType: ListOfCelestialBody) -> ([String], [String])? {

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
}
