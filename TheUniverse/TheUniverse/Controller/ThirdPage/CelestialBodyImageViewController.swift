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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupcCelestialBodyImageView()
        setupNavigationController()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar foto", style: .plain, target: self, action: #selector(downloadTapped))
        // Do any additional setup after loading the view.
    }
    
    @objc
    func downloadTapped() {
        guard let image = celestialBodyImageView.image else {
            print("Erro em salvar a imagem")
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        navigationController?.popToRootViewController(animated: true)
    }

    func setupcCelestialBodyImageView() {
        view.addSubview(celestialBodyImageView)
        celestialBodyImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            self.celestialBodyImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            self.celestialBodyImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.celestialBodyImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
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
