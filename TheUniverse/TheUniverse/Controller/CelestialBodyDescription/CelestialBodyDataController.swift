//
//  CelestialBodyDescriptionViewController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 20/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit
import AVFoundation

class CelestialBodyDataViewController: UIViewController {

    var celestialBodyDescriptionTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.backgroundView = UIImageView(image: UIImage(named: "cosmos"))
        return table
    }()

    var viewModel: CelestialBodyDataViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        speakConfigurations()
        tableViewConfigurations()
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
        CelestialBodyInformationsTableViewCell.speechSynthesizer.stopSpeaking(at: AVSpeechBoundary(rawValue: 0)!)
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
        self.navigationItem.title = viewModel?.getCelestialBodyName()
        navigationController!.navigationBar.tintColor = .defaultGreen
    }

    private func tableViewConfigurations() {
        self.view.backgroundColor = .black
        celestialBodyDescriptionTableView.delegate = self
        celestialBodyDescriptionTableView.dataSource = self
        celestialBodyDescriptionTableView.register(
            CelestialBodyInformationsTableViewCell.self, forCellReuseIdentifier: "celestialBodyDescriptionCell")
        celestialBodyDescriptionTableView.register(
            CelestialBodyImagesTableViewCell.self, forCellReuseIdentifier: "celestialBodyImageCollectionCell")
        celestialBodyDescriptionTableView.register(
            ARButtonSection.self, forCellReuseIdentifier: "ARButtonSection")
    }

    private func speakConfigurations() {
        CelestialBodyInformationsTableViewCell.celestialBodyInformationForSpeech = ""

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "speaker.wave.2"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(speechTaped))
    }

    @objc func speechTaped() {
        if CelestialBodyInformationsTableViewCell.speechSynthesizer.isSpeaking {
            CelestialBodyInformationsTableViewCell.speechSynthesizer.stopSpeaking(at: AVSpeechBoundary(rawValue: 0)!)
            return
        }
        CelestialBodyInformationsTableViewCell.setupSpeechSynthesizer()
    }
}
