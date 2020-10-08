//
//  CelestialBodyDescriptionModel.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 20/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

class CelestialBodyDescriptionModel {

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
