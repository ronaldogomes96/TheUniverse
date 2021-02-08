//
//  Repository.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 05/09/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

class Repository {

    private var urlPath: URL

    init(filename: String) {

        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var fileUrl = url.appendingPathComponent(filename)
        fileUrl = fileUrl.appendingPathExtension("json")
        self.urlPath = fileUrl
    }

    func save(_ imageUrl: String) -> Bool {
        do {
            var celestialBodyImageURL: CelestialBodyImagesUrls
            if !FileManager.default.fileExists(atPath: urlPath.path) {
                celestialBodyImageURL = CelestialBodyImagesUrls(urlOfCelestialBodyImages: [imageUrl])
            } else {
                celestialBodyImageURL = self.load()!
                celestialBodyImageURL.urlOfCelestialBodyImages.append(imageUrl)
            }
            let jsonData = try JSONEncoder().encode(celestialBodyImageURL)
            try jsonData.write(to: urlPath)
            return true
        } catch {
            print(error)
            return false
        }
    }

    func load() -> CelestialBodyImagesUrls? {
        var celestialBodiesImageUrl: CelestialBodyImagesUrls?
        do {
            let jsonData = try Data(contentsOf: urlPath)
            celestialBodiesImageUrl = try JSONDecoder().decode(CelestialBodyImagesUrls.self, from: jsonData)
            return celestialBodiesImageUrl
        } catch {
            print(error)
            return celestialBodiesImageUrl
        }
    }
}
