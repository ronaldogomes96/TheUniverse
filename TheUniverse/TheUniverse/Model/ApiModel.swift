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

    var listOfImages: UIImage?
    var responseStruct: Response?
    private let imageCache = NSCache<NSString, UIImage>()

    func nasaApiCall( celestialBodyNames: String, indexImage: Int, session: URLSession = URLSession.shared, completion: @escaping (UIImage?) -> Void) {

        listOfImages = nil
        let celestialBodyEnglishName = CelestialBodyNames(rawValue: celestialBodyNames)!.englishNameOfCelestialBody
        let repository = Repository(filename: celestialBodyNames)

        let requestURL = requestUrl(url:
            "https://images-api.nasa.gov/search?q=\(celestialBodyEnglishName)&media_type=image")

        let task = session.dataTask(with: requestURL) { (data,_, error) in

            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {

                self.responseStruct = try JSONDecoder().decode(Response.self, from: data)
                let imageUrl = self.responseStruct!.collection.items[indexImage].links.first?.href
                _ = repository.save(imageUrl!)

                let group = DispatchGroup()
                group.enter()

                self.fetchImage(urlString: imageUrl!) { image in
                    self.listOfImages = image
                    group.leave()
                }

                group.notify(queue: .global()) {
                    completion(self.listOfImages!)
                }

            } catch {
                completion(nil)
            }
        }
        task.resume()
    }

    func fetchImage(urlString: String, session: URLSession = URLSession.shared, completion: @escaping (UIImage?) -> Void) {

        let requestURL = requestUrl(url: urlString)

        if let cachedImage = imageCache.object(forKey: requestURL.absoluteString as NSString) {
            let image = cachedImage
            completion(image)
        } else {
            let task = session.downloadTask(with: requestURL) { (urlResponse, _, error) in
                guard let url = urlResponse, error == nil else {
                    completion(nil)
                    return
                }

                do {
                    let data = try Data(contentsOf: url)
                    let imagePlanet = UIImage(data: data)
                    self.imageCache.setObject(imagePlanet!, forKey: requestURL.absoluteString as NSString)
                    completion(imagePlanet!)
                } catch {
                    completion(nil)
                    return
                }
            }
            task.resume()
        }
    }

    func requestUrl (url: String) -> URL {
        let url = URL(string: url)
        guard let requestUrl = url else {fatalError()}
        return requestUrl
    }
}
