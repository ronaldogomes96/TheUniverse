//
//  CelestialBodyNames.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 19/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation

enum CelestialBodyNames: String {

    case mercury = "Mercurio"
    case venus = "Venus"
    case earth = "Terra"
    case mars = "Marte"
    case jupiter = "Jupiter"
    case saturn = "Saturno"
    case uranus = "Urano"
    case neptune = "Neturno"
    case pluto = "Plutão"
    case moon = "Lua"
    case phobos = "Fobos"
    case titan = "Titã"
    case rhea = "Reia"
    case enceladus = "Encélado"
    case ganymede = "Ganimedes"
    case callisto = "Calisto"
    case io = "Io"
    case titania = "Titânia"
    case triton = "Tritão"
    case charon = "Caronte"
    case sun = "Sol"

    var englishNameOfCelestialBody: String {
        switch self {
        case .mercury:
            return "mercury"
        case .venus:
            return "venus"
        case .earth:
            return "earth"
        case .mars:
            return "mars"
        case .jupiter:
            return "jupiter"
        case .saturn:
            return "saturn"
        case .uranus:
            return "uranus"
        case .neptune:
            return "neptune"
        case .pluto:
            return "pluto"
        case .moon:
            return "moon"
        case .phobos:
            return "phobos"
        case .titan:
            return "titan"
        case .rhea:
            return "rhea"
        case .enceladus:
            return "enceladus"
        case .ganymede:
            return "ganymede"
        case .callisto:
            return "callisto"
        case .io:
            return "io"
        case .titania:
            return "titania"
        case .triton:
            return "triton"
        case .charon:
            return "charon"
        case .sun:
            return "sun"
        }
    }
}
