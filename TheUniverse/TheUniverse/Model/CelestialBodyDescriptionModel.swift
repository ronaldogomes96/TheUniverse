//
//  CelestialBodyDescriptionModel.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 20/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

class CelestialBodyDescriptionModel<T: CelestialBodyDescription> {

    func getCelestialBodyDescription(celestialBody: String) -> T? {

        let celestialBodyName = CelestialBodyNames(rawValue: celestialBody)?.englishNameOfCelestialBody
        let celestialBodyDescriptionFromJson = getCelestialBodyDescriptionFromJson(jsonName: celestialBodyName!)

        return celestialBodyDescriptionFromJson!
    }

    func getCelestialBodyDescriptionFromJson(jsonName: String) -> T? {

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
            celestialBodyDescription = try JSONDecoder().decode(T.self, from: data)
        } catch {
            print(error)
            return nil
        }

        return (celestialBodyDescription as! T)
    }
}
