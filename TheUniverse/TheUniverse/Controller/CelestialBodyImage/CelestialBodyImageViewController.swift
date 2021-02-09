//
//  CelestialBodyImageViewController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 21/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class CelestialBodyImageViewController: UIViewController {

    let celestialBodyImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        image.backgroundColor = .black
        return image
    }()

    var celestialBodyImage: UIImage? {
        didSet {
            celestialBodyImageView.image = celestialBodyImage
        }
    }

    var celestialBodyName: String?

    init() {
        super.init(nibName: nil, bundle: nil)
        celestialBodyImageView.image = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCelestialBodyImageViewConstraints()
        setupNavigationControllerConfigurations()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar foto",
                                                            style: .plain, target: self,
                                                            action: #selector(downloadTapped))
    }

    @objc
    private func downloadTapped() {
        guard let image = celestialBodyImageView.image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        navigationController?.popToRootViewController(animated: true)
    }

    private func setupCelestialBodyImageViewConstraints() {
        view.addSubview(celestialBodyImageView)
        celestialBodyImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            self.celestialBodyImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            self.celestialBodyImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.celestialBodyImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }

    private func setupNavigationControllerConfigurations() {
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.defaultGrey]
        navigationController?.navigationBar.barTintColor = .defaultBlack
        navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = celestialBodyName
        navigationController!.navigationBar.tintColor = .defaultGreen
    }
}
