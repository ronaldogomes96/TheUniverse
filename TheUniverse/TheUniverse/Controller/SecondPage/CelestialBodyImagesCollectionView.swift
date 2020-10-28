//
//  CelestialBodyDescriptionViewControllerExtension.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 21/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

extension CelestialBodyImagesTableViewCell: UICollectionViewDelegate,
    UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCell",
                                                      for: indexPath) as? CelestialBodyImagesCollectionViewCell

        let repository = Repository(filename: celestialBodyName!)
        let urlImage = repository.load()

        if let urlImages = urlImage, urlImages.urlOfCelestialBodyImages.count > indexPath.row {
           apiModel.fetchImage(urlString: urlImages.urlOfCelestialBodyImages[indexPath.row]) { image in
                DispatchQueue.main.async {
                    cell!.celestialBodyImage = image
                    self.listOfImages.append(image)
                }
            }
        } else {
            apiModel.nasaApiCall(celestialBodyNames: celestialBodyName!, indexImage: indexPath.row) { image in
                DispatchQueue.main.async {
                    cell!.celestialBodyImage = image
                    self.listOfImages.append(image)
                }
            }
        }

        return cell!
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let celestialBodyImageController = CelestialBodyImageViewController()
        celestialBodyImageController.celestialBodyName = celestialBodyName
        celestialBodyImageController.celestialBodyImage = listOfImages[indexPath.row]
        viewController?.navigationController?.pushViewController(celestialBodyImageController, animated: true)
    }
}
