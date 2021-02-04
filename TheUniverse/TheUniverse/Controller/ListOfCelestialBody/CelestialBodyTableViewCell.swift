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

    let celestialBodyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .defaultGrey
        label.font = UIFont.SFProRoundedTitle
        label.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        label.backgroundColor = .clear
        return label
    }()

    let celestialBodyImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        image.backgroundColor = .clear
        return image
    }()

    override func prepareForReuse() {
        celestialBodyNameLabel.text = ""
        celestialBodyImageView.image = nil
    }

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
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.clipsToBounds = true
        setupcCelestialBodyImageView()
        setupcCelestialBodyNameLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupcCelestialBodyImageView() {
        self.addSubview(celestialBodyImageView)
        celestialBodyImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyImageView.bottomAnchor.constraint(equalTo:
                self.bottomAnchor, constant: 0),
            self.celestialBodyImageView.topAnchor.constraint(equalTo:
                self.topAnchor, constant: 0),
            self.celestialBodyImageView.leadingAnchor.constraint(equalTo:
                self.leadingAnchor, constant: 20),
            celestialBodyImageView.widthAnchor.constraint(equalTo:
                self.heightAnchor)
        ])
    }

    func setupcCelestialBodyNameLabel() {
        self.addSubview(celestialBodyNameLabel)
        celestialBodyNameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyNameLabel.bottomAnchor.constraint(equalTo:
                self.bottomAnchor, constant: 0),
            self.celestialBodyNameLabel.topAnchor.constraint(equalTo:
                self.topAnchor, constant: 0),
            self.celestialBodyNameLabel.leadingAnchor.constraint(equalTo:
                self.celestialBodyImageView.trailingAnchor, constant: 30),
            self.celestialBodyNameLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}
