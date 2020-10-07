//
//  CelestialBodyDescription.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 20/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation

protocol CelestialBodyDescription: Codable {
    var introduction: String { get set }
    var sizeAndDistance: String { get set }
    var orbitAndRotation: String { get set }
    var structure: String { get set }
    var surface: String { get set }
    var atmosphereAndMagnetosphere: String { get set }
    var potentialForLife: String { get set }
    //Fazer um protocolo, que sera decodable, e ira ser de planet, moon e star, e fazer o celestial body description ser generico
}
