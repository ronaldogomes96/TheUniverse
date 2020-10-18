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
            return celestialBodyInfos?.info.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section ==  0 {
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "celestialBodyImageCollectionCell",
                    for: indexPath) as? CelestialBodyImagesTableViewCell  else {
                fatalError()
            }

            cell.celestialBodyName = celestialBodyName
            return cell

        } else {
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "celestialBodyDescriptionCell", for: indexPath) as?
                    CelestialBodyDescriptionTableViewCell else {
                fatalError()
            }

            cell.celestialBodyName = celestialBodyName
            cell.indexPathForCell = indexPath.row
            cell.setupImage()
            cell.celestialBodyTittleLabel.text = celestialBodyInfos?.info[indexPath.row].title
            cell.celestialBodyDescriptionLabel.text = celestialBodyInfos?.info[indexPath.row].description
            return cell
        }
    }
}
