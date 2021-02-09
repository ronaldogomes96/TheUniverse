//
//  CelestialBodyImageViewModel.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 05/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import UIKit

class CelestialBodyImagesViewModel: ImageForApiResponse {

    internal var celestialBodyName: String
    internal var apiModel: ApiModel = ApiModel()
    internal var repository: Repository

    init(celestialBodyName: String) {
        self.celestialBodyName = celestialBodyName
        self.repository = Repository(filename: self.celestialBodyName)
    }
}
