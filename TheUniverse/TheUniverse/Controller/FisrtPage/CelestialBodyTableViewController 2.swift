//
//  PlanetSatelliteStarTableViewController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 14/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class CelestialBodyTableViewController: UITableViewController {

    var celestialBodyNames: [String]?
    var celestialBodyImageNames: [String]?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .defaultBlack
        tableView.register(CelestialBodyTableViewCell.self, forCellReuseIdentifier: "celestialBodyCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return celestialBodyNames!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "celestialBodyCell", for: indexPath) as? CelestialBodyTableViewCell

        cell!.celestialBodyName = celestialBodyNames![indexPath.row]
        cell!.celestialBodyImage = UIImage(named: celestialBodyImageNames![indexPath.row])

        return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
