import Foundation

// swiftlint:disable identifier_name

enum CelestialBodyNames: String {
    case mercury = "Mercúrio"
    case venus = "Vênus"
    case earth = "Terra"
    case mars = "Marte"
    case jupiter = "Júpiter"
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
        case .mars:
            return "mars-planet"
        case .neptune:
            return "neptune"
        default:
            return String(describing: self)
        }
    }

    var correctedDisplayName: String {
        self == .neptune ? "Netuno" : rawValue
    }

    var modelAssetName: String? {
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

    @available(*, deprecated, renamed: "modelAssetName")
    var nameof3Dassert: String? {
        modelAssetName
    }
}
