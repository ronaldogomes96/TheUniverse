//
//  ImagesCollectionTableViewCell.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 09/10/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class CelestialBodyImagesTableViewCell: UITableViewCell {

    let imagesCollectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        let collec = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collec.isPagingEnabled = true
        return collec
    }()

    var collectionController: CelestialBodyImagesCollectionController? {
        didSet {
            collectionConfiguration()
            imagesCollectionView.reloadData()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layoutConfigurations()
        setupImageCollectionConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageCollectionConstraint() {
        self.addSubview(imagesCollectionView)
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstat = self.imagesCollectionView.heightAnchor.constraint(equalToConstant: 260)
        heightConstat.priority = .defaultLow

        NSLayoutConstraint.activate([
            self.imagesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                                constant: 0),
            self.imagesCollectionView.topAnchor.constraint(equalTo: self.topAnchor,
                                                                constant: 0),
            self.imagesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                               constant: 0),
            self.imagesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                constant: 0),
            heightConstat
        ])
    }

    private func collectionConfiguration() {
        imagesCollectionView.delegate = collectionController
        imagesCollectionView.dataSource = collectionController
        imagesCollectionView.register(
            CelestialBodyImagesCollectionViewCell.self,
            forCellWithReuseIdentifier: "imagesCell" )
    }

    private func layoutConfigurations() {
        self.contentView.isUserInteractionEnabled = false
        self.isSelected = false
        self.backgroundColor = .clear
    }
}
