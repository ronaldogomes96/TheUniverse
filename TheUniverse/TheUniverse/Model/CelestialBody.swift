//
//  CelestialBody.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 16/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

struct CelestialBody: Decodable{
    let planets: Planets
    let satellites: Satellites
    let stars: Stars
}

struct Planets: Decodable {
    let name: [String]
    let image: [String]
}

struct Satellites: Decodable {
    let name: [String]
    let image: [String]
}

struct Stars: Decodable {
    let name: [String]
    let image: [String]
}
