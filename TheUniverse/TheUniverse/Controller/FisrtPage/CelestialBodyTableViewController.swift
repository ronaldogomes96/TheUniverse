//
//  PlanetSatelliteStarTableViewController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 14/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class CelestialBodyTableViewController: UITableViewController {

    var celestialBodyNames: [String]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    var celestialBodyImageNames: [String]? {
        didSet {
            self.tableView.reloadData()
        }
    }

    let celestialBodyModel = CelestialBodyModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.tabBarController?.tabBar.tintColor = .defaultGreen
        setupNavigationController()
        tableView.register(CelestialBodyTableViewCell.self, forCellReuseIdentifier: "celestialBodyCell")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return celestialBodyNames?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "celestialBodyCell", for: indexPath) as? CelestialBodyTableViewCell

        cell!.celestialBodyName = celestialBodyNames![indexPath.row]
        cell!.celestialBodyImage = UIImage(named: celestialBodyImageNames![indexPath.row])

        return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let celestialBodyData = CelestialBodyDataViewController()
        celestialBodyData.celestialBodyName = celestialBodyNames![indexPath.row]
        celestialBodyData.celestialBodyInfos =
            celestialBodyModel.getCelestialBodyDescription(celestialBody:
            celestialBodyNames![indexPath.row])
        navigationController?.pushViewController(celestialBodyData, animated: true)
    }

    func setupNavigationController() {
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.defaultGrey]
        navigationController?.navigationBar.barTintColor = .defaultBlack
        navigationController?.navigationBar.isTranslucent = false
    }
}
