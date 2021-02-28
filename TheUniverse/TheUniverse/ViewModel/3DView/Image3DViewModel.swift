//
//  Image3DViewModel.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 27/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import Foundation

class Image3DViewModel {
    
    private let celestialBodyName: String

    init(name: String) {
        celestialBodyName = name
    }

    func getAssertName() -> String? {
        let modelName = CelestialBodyNames(rawValue: celestialBodyName)
        return modelName?.nameof3Dassert
    }
}
