//
//  ImagesCollectionTableViewCell.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 09/10/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class ImagesCollectionTableViewCell: UITableViewCell {
    
    var imagesCollectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        //flow.itemSize =
        let collec = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collec.isPagingEnabled = true
        return collec
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(
            ImagesCollectionCell.self,
            forCellWithReuseIdentifier: "imagesCell" )
        setupImageCollection() 
    }
    
    let apiModel = ApiModel()
    var celestialBodyName: String?
    var listOfImages: [UIImage] = []

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupImageCollection() {
        
        self.addSubview(imagesCollectionView)
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.imagesCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                                constant: 0),
            self.imagesCollectionView.topAnchor.constraint(equalTo: self.topAnchor,
                                                                constant: 0),
            self.imagesCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                               constant: 0),
            self.imagesCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                constant: 0)
        ])
    }

}
