//
//  CelestialBodyDescriptionTableViewController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 08/10/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

extension CelestialBodyDescriptionViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        } else {
            return celestialBodyInfos?.info.count ?? 0
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "celestialBodyImageCollectionCell", for: indexPath) as? ImagesCollectionTableViewCell {
            
            cell.celestialBodyName = celestialBodyName
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: "celestialBodyDescriptionCell", for: indexPath) as?
                    CelestialBodyDescriptionTableViewCell else {
                fatalError()
            }
            cell.indexPathForCell = indexPath.row
            cell.celestialBodyName = celestialBodyName
            cell.celestialBodyTittleLabel.text = celestialBodyInfos?.info[indexPath.row].title
            cell.celestialBodyDescriptionLabel.text = celestialBodyInfos?.info[indexPath.row].description
            return cell
        }
    }
}