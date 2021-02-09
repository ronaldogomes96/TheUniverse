//
//  CelestialBody.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 16/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

struct CelestialBody: Codable {
    let planets: Planets
    let satellites: Satellites
    let stars: Stars
}

struct Planets: Codable {
    let name: [String]
    let image: [String]
}

struct Satellites: Codable {
    let name: [String]
    let image: [String]
}

struct Stars: Codable {
    let name: [String]
    let image: [String]
}
