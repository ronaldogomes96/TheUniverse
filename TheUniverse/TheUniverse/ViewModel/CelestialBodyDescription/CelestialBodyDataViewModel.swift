//
//  CelestialBodyDataViewModel.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 05/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import Foundation

class CelestialBodyDataViewModel {
    
    private let indexOfCelestialBody: Int
    private let celestialBodyName: String
    private var celestialBodyDescription: CelestialBodyInformations?
    private let model = CelestialBodyModel()

    init(indexOf: Int, celestialBodyName: String) {
        self.indexOfCelestialBody = indexOf
        self.celestialBodyName = celestialBodyName
        self.celestialBodyDescription = getCelestialBodyDescription()
    }
    
    func getCelestialBodyDescription() -> CelestialBodyInformations? {
        return model.getCelestialBodyDescription(celestialBody: celestialBodyName)
    }
    
    func numberOfDescriptions() -> Int? {
        return celestialBodyDescription?.info.count
    }
    
    func getCelestialBodyName() -> String {
        return celestialBodyName
    }
}
