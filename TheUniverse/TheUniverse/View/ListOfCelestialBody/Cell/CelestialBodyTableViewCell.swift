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

    lazy var celestialBodyView: CelestialBodyViewCell =  {
        let celestialBodyView = CelestialBodyViewCell()
        celestialBodyView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(celestialBodyView)
        return celestialBodyView
    }()

    override func prepareForReuse() {
        celestialBodyView.celestialBodyName.text = ""
        celestialBodyView.celestialBodyImage.image = nil
    }

    var celestialBodyName: String? {
        didSet {
            celestialBodyView.celestialBodyName.text = celestialBodyName
        }
    }

    var celestialBodyImage: UIImage? {
        didSet {
            celestialBodyView.celestialBodyImage.image = celestialBodyImage
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellLayout()
        configureConstraintForCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureConstraintForCell() {
        NSLayoutConstraint.activate([
            celestialBodyView.topAnchor.constraint(equalTo: self.topAnchor),
            celestialBodyView.leftAnchor.constraint(equalTo: self.leftAnchor),
            celestialBodyView.rightAnchor.constraint(equalTo: self.rightAnchor),
            celestialBodyView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func configureCellLayout() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.clipsToBounds = true
    }
}
