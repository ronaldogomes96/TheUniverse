//
//  CelestialBodyDescriptionTableViewController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 08/10/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

extension CelestialBodyDataViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel?.numberOfDescriptions() ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section ==  0 {
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "celestialBodyImageCollectionCell",
                    for: indexPath) as? CelestialBodyImagesTableViewCell  else {
                fatalError()
            }

            cell.collectionController = getCelestialBodyImagesCollectionController()

            return cell

        } else {
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "celestialBodyDescriptionCell", for: indexPath) as?
                    CelestialBodyInformationsTableViewCell else {
                fatalError()
            }

            cell.viewModel = CelestialBodyInformationsViewModel(celestialBodyName:
                                                                    viewModel?.getCelestialBodyName() ?? "",
                                                                  indexPathForCell: indexPath.row)

            return cell
        }
    }

    private func getCelestialBodyImagesCollectionController() -> CelestialBodyImagesCollectionController {
        let handler: ((String, UIImage) -> Void) = { [weak self] celestialBodyName, celestialBodyImage in
            let celestialBodyImageController = CelestialBodyImageViewController()
            //Receber a viewModel
//                celestialBodyImageController.celestialBodyName = celestialBodyName
//                celestialBodyImageController.celestialBodyImage = celestialBodyImage
            self?.navigationController?.pushViewController(celestialBodyImageController, animated: true)
        }

        let imageViewModel = CelestialBodyImagesViewModel(celestialBodyName:
                                                         viewModel?.getCelestialBodyName() ?? "")
        let imagesCollectionController = CelestialBodyImagesCollectionController(
            viewModel: imageViewModel, handler: handler)

        return imagesCollectionController
    }
}
