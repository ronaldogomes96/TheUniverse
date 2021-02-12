//
//  CelestialBodyDataCollectionController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 08/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import UIKit

class CelestialBodyImagesCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var viewModel: CelestialBodyImagesViewModel
    private var handler: ((String, UIImage) -> Void)

    init(viewModel: CelestialBodyImagesViewModel, handler: @escaping ((String, UIImage) -> Void)) {
        self.viewModel = viewModel
        self.handler = handler
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "imagesCell")
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "imagesCell",
                for: indexPath) as? CelestialBodyImagesCollectionViewCell else {
            fatalError()
        }

        viewModel.imageForApi(index: indexPath.row) { image in
            DispatchQueue.main.async {
                cell.celestialBodyImage = image
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.imageForApi(index: indexPath.row) { image in
            DispatchQueue.main.async {
                if let image = image {
                    self.handler(self.viewModel.getCelestialBodyName(), image)
                }
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {

        CelestialBodyImagesTableViewCell.numberOfCells = indexPath.row + 1
    }
}
