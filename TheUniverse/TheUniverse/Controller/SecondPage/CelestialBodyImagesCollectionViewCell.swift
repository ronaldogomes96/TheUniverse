//
//  CelestialBodyDescriptionCollectionViewCell.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 21/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
// swiftlint:disable type_name

import UIKit
import Foundation

class CelestialBodyImagesCollectionViewCell: UICollectionViewCell {

    var celestialBodyImageView: UIImageView = {
        let image  = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        return image
    }()

    var celestialBodyImage: UIImage? {
        didSet {
            celestialBodyImageView.image = celestialBodyImage
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraintsCelestialBodyImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        celestialBodyImageView.image = nil
    }

    func setupConstraintsCelestialBodyImageView() {
        self.addSubview(celestialBodyImageView)
        celestialBodyImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            self.celestialBodyImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.celestialBodyImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.celestialBodyImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
    }
}
