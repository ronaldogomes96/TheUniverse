//
//  CelestialBodyInformationsViewModel.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 05/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import Foundation

class CelestialBodyInformationsViewModel: ImageForApiResponse {

    internal var celestialBodyName: String
    internal var apiModel: ApiModel = ApiModel()
    internal var repository: Repository
    private let model = CelestialBodyModel()
    let celestialBody: CelestialBodyInformations?
    let indexPathForCell: Int

    init(celestialBodyName: String, indexPathForCell: Int) {
        self.celestialBodyName = celestialBodyName
        self.repository = Repository(filename: self.celestialBodyName)
        self.celestialBody = model.getCelestialBodyDescription(celestialBody: celestialBodyName)
        self.indexPathForCell = indexPathForCell
    }

    func getCelestialBodyDescriptionTittle() -> String {
        return celestialBody?.info[indexPathForCell].title ?? ""
    }

    func getCelestialBodyDescriptionString() -> String {
        return celestialBody?.info[indexPathForCell].description ?? ""
    }
}
