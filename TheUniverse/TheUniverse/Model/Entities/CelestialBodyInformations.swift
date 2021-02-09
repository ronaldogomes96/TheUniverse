//
//  CelestialBodyDescription.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 20/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
// swiftlint:disable type_name

import Foundation

struct CelestialBodyInformations: Codable {
    let info: [info]
}

struct info: Codable {
    let title: String
    let description: String
}
