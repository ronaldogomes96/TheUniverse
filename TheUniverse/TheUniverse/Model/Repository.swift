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

    var urlPath: URL

    init(filename: String) {

        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var fileUrl = url.appendingPathComponent(filename)
        fileUrl = fileUrl.appendingPathExtension("json")
        self.urlPath = fileUrl
    }

    func save(_ imageUrl: String) -> Bool {
        do {
            var celestialBodyImageURL: CelestialBodyImages
            if !FileManager.default.fileExists(atPath: urlPath.path) {
                celestialBodyImageURL = CelestialBodyImages(urlOfCelestialBodyImages: [imageUrl])
            } else {
                celestialBodyImageURL = self.load()!
                celestialBodyImageURL.urlOfCelestialBodyImages.append(imageUrl)
            }
            let jsonData = try JSONEncoder().encode(celestialBodyImageURL)
            try jsonData.write(to: urlPath)
            return true
        } catch {
            print("It was not possible to save the celestial bodies.")
            return false
        }
    }

    func load() -> CelestialBodyImages? {
        var celestialBodiesImageUrl: CelestialBodyImages?
        do {
            let jsonData = try Data(contentsOf: urlPath)
            celestialBodiesImageUrl = try JSONDecoder().decode(CelestialBodyImages.self, from: jsonData)
            return celestialBodiesImageUrl
        } catch {
            print("It was not possible to load the celestial bodies.")
            return celestialBodiesImageUrl
        }
    }
}
