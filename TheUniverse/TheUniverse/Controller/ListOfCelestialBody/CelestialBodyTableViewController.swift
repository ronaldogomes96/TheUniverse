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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationControllerLayout()
        setupTableViewConfigurations()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return celestialBodyNames?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
                                                        "celestialBodyCell",
                                                       for: indexPath) as? CelestialBodyTableViewCell else {
            fatalError()
        }

        cell.celestialBodyName = celestialBodyNames?[indexPath.row]
        cell.celestialBodyImage = UIImage(named: celestialBodyImageNames?[indexPath.row] ?? "")

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let celestialBodyData = CelestialBodyDataViewController()
        celestialBodyData.viewModel = CelestialBodyDataViewModel(celestialBodyName:
                                                                    celestialBodyNames![indexPath.row])
        navigationController?.pushViewController(celestialBodyData, animated: true)
    }

    private func setupNavigationControllerLayout() {
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.defaultGrey]
        navigationController?.navigationBar.barTintColor = .defaultBlack
        navigationController?.navigationBar.isTranslucent = false
    }

    private func setupTableViewConfigurations() {
        self.view.backgroundColor = .clear
        tableView.backgroundView = UIImageView(image: UIImage(named: "cosmos"))
        tableView.register(CelestialBodyTableViewCell.self, forCellReuseIdentifier: "celestialBodyCell")
        tableView.separatorStyle = .none
    }
}
