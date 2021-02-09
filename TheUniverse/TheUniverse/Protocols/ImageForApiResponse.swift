//
//  ImageForApiResponse.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 05/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

protocol ImageForApiResponse {
    var celestialBodyName: String { get }
    var apiModel: ApiModel { get set }
    var repository: Repository { get }

    func imageForApi(index: Int, completion: @escaping (UIImage?) -> Void)
}

extension ImageForApiResponse {
    func imageForApi(index: Int, completion: @escaping (UIImage?) -> Void) {
        let urlImage = repository.load()

        if let urlImages = urlImage, urlImages.urlOfCelestialBodyImages.count > index {
            apiModel.fetchImage(urlString: urlImages.urlOfCelestialBodyImages[index]) { image in
                completion(image)
            }
        } else {
            apiModel.nasaApiCall(celestialBodyNames: celestialBodyName, indexImage: index) { image in
                completion(image)
            }
        }
    }

    func getCelestialBodyName() -> String {
        return celestialBodyName
    }
}
