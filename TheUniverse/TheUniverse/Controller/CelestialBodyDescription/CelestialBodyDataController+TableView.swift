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
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            if viewModel!.have3DAssert() {
                return 1
            }
            return 0
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

        } else if indexPath.section ==  1 {
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "ARButtonSection",
                    for: indexPath) as? ARButtonSection  else {
                fatalError()
            }

            cell.celestialBodyName = viewModel?.getCelestialBodyName()
            cell.handler = { [weak self] controller in
                self?.navigationController?.pushViewController(controller, animated: true)
            }

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
            celestialBodyImageController.celestialBodyName = celestialBodyName
            celestialBodyImageController.celestialBodyImage = celestialBodyImage
            self?.navigationController?.pushViewController(celestialBodyImageController, animated: true)
        }

        let imageViewModel = CelestialBodyImagesViewModel(celestialBodyName:
                                                         viewModel?.getCelestialBodyName() ?? "")
        let imagesCollectionController = CelestialBodyImagesCollectionController(
            viewModel: imageViewModel, handler: handler)

        return imagesCollectionController
    }
}
