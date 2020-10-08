//
//  CelestialBodyDescription.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 20/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation

struct CelestialBodyDescription: Codable {
    let info: [info]
}

struct info: Codable {
    let title: String
    let description: String
}
