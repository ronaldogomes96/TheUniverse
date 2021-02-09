//
//  CelestialBodyDescriptionViewController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 20/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class CelestialBodyDataViewController: UIViewController {

    var celestialBodyDescriptionTableView: UITableView = {
        let table = UITableView()
        return table
    }()

    var celestialBodyName: String?
    var celestialBodyInfos: CelestialBodyDescription?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black
        celestialBodyDescriptionTableView.delegate = self
        celestialBodyDescriptionTableView.dataSource = self
        celestialBodyDescriptionTableView.register(
            CelestialBodyDescriptionTableViewCell.self, forCellReuseIdentifier: "celestialBodyDescriptionCell")
        celestialBodyDescriptionTableView.register(
            CelestialBodyImagesTableViewCell.self, forCellReuseIdentifier: "celestialBodyImageCollectionCell")

        setupCelestialBodyTableView()
        setupNavigationController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        celestialBodyDescriptionTableView.rowHeight = UITableView.automaticDimension
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.celestialBodyDescriptionTableView.reloadData()
    }

    func setupCelestialBodyTableView() {
        view.addSubview(celestialBodyDescriptionTableView)
        celestialBodyDescriptionTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyDescriptionTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            self.celestialBodyDescriptionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.celestialBodyDescriptionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            self.celestialBodyDescriptionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }

    func setupNavigationController() {
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.defaultGrey]
        navigationController?.navigationBar.barTintColor = .defaultBlack
        navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = celestialBodyName
        navigationController!.navigationBar.tintColor = .defaultGreen
    }
}
