//
//  ApiModel.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 19/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

class ApiModel {

    var listOfImages: [UIImage] = []
    var responseStruct: Response?

    func nasaApiCall( celestialBodyNames: String, completion: @escaping ([UIImage]) -> Void) {

        listOfImages = []
        let celestialBodyEnglishName = CelestialBodyNames(rawValue: celestialBodyNames)!.englishNameOfCelestialBody

        let requestURL = requestUrl(url:
            "https://images-api.nasa.gov/search?q=\(celestialBodyEnglishName)&media_type=image")

        let task = URLSession.shared.dataTask(with: requestURL) { (data,_, error) in

            guard let data = data, error == nil else {
                fatalError("Erron in \(String(describing: error))")
            }

            do {

                self.responseStruct = try JSONDecoder().decode(Response.self, from: data)
                let group = DispatchGroup()

                for index in 0..<10 {
                    group.enter()

                    self.fetchImage(urlString:
                    (self.responseStruct!.collection.items[index].links.first?.href)!) { image in
                        self.listOfImages.append(image)
                        group.leave()
                    }
                }

                group.notify(queue: .global()) {
                    completion(self.listOfImages)
                }

            } catch {
                fatalError("Erron in \(String(describing: error))")
            }
        }
        task.resume()
    }

    func fetchImage(urlString: String, completion: @escaping (UIImage) -> Void) {

        let requestURL = requestUrl(url: urlString)

        let task = URLSession.shared.downloadTask(with: requestURL) { (urlResponse, _, error) in
            guard let url = urlResponse, error == nil else {
                fatalError("Erron in \(String(describing: error))")
            }

            do {
                let data = try Data(contentsOf: url)
                let imagePlanet = UIImage(data: data)
                completion(imagePlanet!)
            } catch {
                fatalError("Erron in \(String(describing: error))")
            }
        }
        task.resume()
    }

    func requestUrl (url: String) -> URL {
        let url = URL(string: url)
        guard let requestUrl = url else {fatalError()}
        return requestUrl
    }
}
