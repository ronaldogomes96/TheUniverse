//
//  CelestialBodyViewCell.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 04/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import UIKit

class CelestialBodyViewCell: UIView {

    let celestialBodyName: UILabel = {
        let label = UILabel()
        label.textColor = .defaultGrey
        label.font = UIFont.SFProRoundedTitle
        label.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        label.backgroundColor = .clear
        return label
    }()

    let celestialBodyImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        image.backgroundColor = .clear
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraintForImageView()
        setupConstraintForLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraintForImageView() {
        self.addSubview(celestialBodyImage)
        celestialBodyImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyImage.bottomAnchor.constraint(equalTo:
                self.bottomAnchor, constant: 0),
            self.celestialBodyImage.topAnchor.constraint(equalTo:
                self.topAnchor, constant: 0),
            self.celestialBodyImage.leadingAnchor.constraint(equalTo:
                self.leadingAnchor, constant: 20),
            celestialBodyImage.widthAnchor.constraint(equalTo:
                self.heightAnchor)
        ])
    }

    private func setupConstraintForLabel() {
        self.addSubview(celestialBodyName)
        celestialBodyName.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyName.bottomAnchor.constraint(equalTo:
                self.bottomAnchor, constant: 0),
            self.celestialBodyName.topAnchor.constraint(equalTo:
                self.topAnchor, constant: 0),
            self.celestialBodyName.leadingAnchor.constraint(equalTo:
                self.celestialBodyImage.trailingAnchor, constant: 30),
            self.celestialBodyName.trailingAnchor.constraint(
                equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}
