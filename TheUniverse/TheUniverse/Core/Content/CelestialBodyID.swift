import Foundation

enum CelestialCategory: String, CaseIterable, Identifiable {
    case planets
    case satellites
    case stars
    case events
    case missions

    var id: String { rawValue }

    var title: String {
        switch self {
        case .planets: return "Planetas"
        case .satellites: return "Satélites"
        case .stars: return "Estrelas"
        case .events: return "Eventos"
        case .missions: return "Missões"
        }
    }

    var systemImage: String {
        switch self {
        case .planets: return "globe.americas.fill"
        case .satellites: return "moon.stars.fill"
        case .stars: return "sparkle"
        case .events: return "calendar"
        case .missions: return "paperplane.fill"
        }
    }
}

enum CelestialBodyID: String, CaseIterable, Codable, Identifiable, Hashable {
    case mercury
    case venus
    case earth
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
    case pluto
    case moon
    case phobos
    case titan
    case rhea
    case enceladus
    case ganymede
    case callisto
    case io
    case titania
    case triton
    case charon
    case sun

    var id: String { rawValue }

    var category: CelestialCategory {
        switch self {
        case .mercury, .venus, .earth, .mars, .jupiter, .saturn, .uranus, .neptune, .pluto:
            return .planets
        case .moon, .phobos, .titan, .rhea, .enceladus, .ganymede, .callisto, .io, .titania, .triton, .charon:
            return .satellites
        case .sun:
            return .stars
        }
    }

    var displayName: String {
        switch self {
        case .mercury: return "Mercúrio"
        case .venus: return "Vênus"
        case .earth: return "Terra"
        case .mars: return "Marte"
        case .jupiter: return "Júpiter"
        case .saturn: return "Saturno"
        case .uranus: return "Urano"
        case .neptune: return "Netuno"
        case .pluto: return "Plutão"
        case .moon: return "Lua"
        case .phobos: return "Fobos"
        case .titan: return "Titã"
        case .rhea: return "Reia"
        case .enceladus: return "Encélado"
        case .ganymede: return "Ganimedes"
        case .callisto: return "Calisto"
        case .io: return "Io"
        case .titania: return "Titânia"
        case .triton: return "Tritão"
        case .charon: return "Caronte"
        case .sun: return "Sol"
        }
    }

    var legacyDisplayName: String {
        switch self {
        case .neptune: return "Neturno"
        default: return displayName
        }
    }

    var jsonResourceName: String {
        switch self {
        case .mars: return "mars-planet"
        default: return rawValue
        }
    }

    var localImageName: String {
        switch self {
        case .mercury: return "Mercurio.jpg"
        case .venus: return "Venus.jpg"
        case .earth: return "Terra.jpg"
        case .mars: return "Marte.jpg"
        case .jupiter: return "Jupiter.jpg"
        case .saturn: return "Saturno.jpg"
        case .uranus: return "Urano.jpg"
        case .neptune: return "Neturno.jpg"
        case .pluto: return "Plutao.jpg"
        case .moon: return "Lua.jpg"
        case .phobos: return "Fobos.jpg"
        case .titan: return "Tita.jpg"
        case .rhea: return "Reia.jpg"
        case .enceladus: return "Encelado.jpg"
        case .ganymede: return "Ganimedes.jpg"
        case .callisto: return "Calisto.jpg"
        case .io: return "Io.jpg"
        case .titania: return "Titania.jpg"
        case .triton: return "Tritao.jpg"
        case .charon: return "Caronte.jpg"
        case .sun: return "Sol.jpg"
        }
    }

    var modelTextureName: String? {
        switch self {
        case .mercury: return "mercury3D.jpg"
        case .venus: return "venus3D.jpg"
        case .earth: return "earth3D.jpg"
        case .mars: return "mars3D.jpg"
        case .jupiter: return "jupiter3D.jpg"
        case .uranus: return "uranus3D.jpg"
        case .neptune: return "neptune3D.jpg"
        case .moon: return "moon3D.jpg"
        case .sun: return "sun3D.jpg"
        default: return nil
        }
    }

    var subtitle: String {
        switch self.category {
        case .planets:
            return self == .earth ? "Nosso mundo azul" : "Planeta do Sistema Solar"
        case .satellites:
            return "Lua e companheira orbital"
        case .stars:
            return "Estrela de referência"
        case .events, .missions:
            return ""
        }
    }

    static func from(displayName: String) -> CelestialBodyID? {
        allCases.first { $0.displayName == displayName || $0.legacyDisplayName == displayName }
    }
}
