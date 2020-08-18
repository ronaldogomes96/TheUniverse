//
//  CelestialBodyTableViewCell.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 17/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit
import Foundation

class CelestialBodyTableViewCell: UITableViewCell {

    var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = false
        image.backgroundColor = .defaultBlack
        return image
    }()

    var celestialBodyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .defaultGrey
        label.font = UIFont.SFProRoundedTitle
        label.backgroundColor = nil
        return label
    }()

    var celestialBodyImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        image.backgroundColor = nil
        return image
    }()

    var cosmosImage = UIImage(named: "cosmos.jpg")

    var celestialBodyName: String? {
        didSet {
            celestialBodyNameLabel.text = celestialBodyName
        }
    }

    var celestialBodyImage: UIImage? {
        didSet {
            celestialBodyImageView.image = celestialBodyImage
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundImage.image = cosmosImage
        setupcbackgroundImage()
        setupcCelestialBodyImageView()
        setupcCelestialBodyNameLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupcbackgroundImage() {
        self.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.backgroundImage.bottomAnchor.constraint(equalTo:
                self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            self.backgroundImage.topAnchor.constraint(equalTo:
                self.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.backgroundImage.leadingAnchor.constraint(equalTo:
                self.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            self.backgroundImage.trailingAnchor.constraint(equalTo:
                self.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }

    func setupcCelestialBodyImageView() {
        self.addSubview(celestialBodyImageView)
        celestialBodyImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyImageView.bottomAnchor.constraint(equalTo:
                self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            self.celestialBodyImageView.topAnchor.constraint(equalTo:
                self.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.celestialBodyImageView.leadingAnchor.constraint(equalTo:
                self.safeAreaLayoutGuide.leadingAnchor, constant: 253),
            self.celestialBodyImageView.trailingAnchor.constraint(equalTo:
                self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }

    func setupcCelestialBodyNameLabel() {
        self.addSubview(celestialBodyNameLabel)
        celestialBodyNameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyNameLabel.bottomAnchor.constraint(equalTo:
                self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            self.celestialBodyNameLabel.topAnchor.constraint(equalTo:
                self.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.celestialBodyNameLabel.leadingAnchor.constraint(equalTo:
                self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.celestialBodyNameLabel.trailingAnchor.constraint(
                equalTo: self.celestialBodyImageView.leadingAnchor, constant: -20)
        ])
    }
}
