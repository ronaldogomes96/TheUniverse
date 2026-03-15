import Foundation

class CelestialBodyDataViewModel {
    private let celestialBodyName: String
    private var celestialBodyDescription: CelestialBodyInformations?
    private let model = CelestialBodyModel()

    init(celestialBodyName: String) {
        self.celestialBodyName = celestialBodyName
        self.celestialBodyDescription = getCelestialBodyDescription()
    }

    func getCelestialBodyDescription() -> CelestialBodyInformations? {
        model.getCelestialBodyDescription(celestialBody: celestialBodyName)
    }

    func numberOfDescriptions() -> Int? {
        celestialBodyDescription?.info.count
    }

    func getCelestialBodyName() -> String {
        celestialBodyName
    }

    func have3DAssert() -> Bool {
        CelestialBodyNames(rawValue: celestialBodyName)?.modelAssetName != nil
    }
}
