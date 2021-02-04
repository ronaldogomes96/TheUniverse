//
//  TabBarViewModel.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 04/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import Foundation

class TabBarViewModel {

    let celestialBody = CelestialBodyModel()

    func getInformationsFromCelestialBody(indexOf: Int) -> ([String], [String]) {

        var informationsFromCelestialBody: ([String], [String]) = ([""], [""])

        switch indexOf {
        case 0:
            informationsFromCelestialBody =
                celestialBody.getListOfNamesAndImagesOfCelestialBody(from: .planets) ?? ([""], [""])
        case 1:
            informationsFromCelestialBody =
                celestialBody.getListOfNamesAndImagesOfCelestialBody(from: .satellites) ?? ([""], [""])
        case 2:
            informationsFromCelestialBody =
                celestialBody.getListOfNamesAndImagesOfCelestialBody(from: .stars) ?? ([""], [""])
        default:
            print("Index out of range")
        }

        return informationsFromCelestialBody
    }
}
