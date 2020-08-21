//
//  CelestialBodyDescriptionViewController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 20/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class CelestialBodyDescriptionViewController: UIViewController {

    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    var scrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .defaultBlack
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var imagesCollectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        let collec = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collec.isPagingEnabled = true
        return collec
    }()

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .defaultGrey
        label.font = UIFont.SFProRoundedDescription
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()

    var celestialBodyDescription: String? {
        didSet {
            descriptionLabel.text = celestialBodyDescription
        }
    }

    var celestialBodyName: String?
    let apiModel = ApiModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self

        imagesCollectionView.register(
            CelestialBodyDescriptionCollectionViewCell.self,
            forCellWithReuseIdentifier: "customCell" )

        setupScrollView()
        setupImageCollection()
        setupCelestialBodyDescription()

        // Do any additional setup after loading the view.
    }

    func setupScrollView() {

        view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)

        let heightAnchorContent = scrollContentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        heightAnchorContent.priority = .defaultLow

        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            scrollContentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    func setupImageCollection() {

        scrollContentView.addSubview(imagesCollectionView)
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.imagesCollectionView.bottomAnchor.constraint(equalTo:
                scrollContentView.safeAreaLayoutGuide.topAnchor, constant: 280),
            self.imagesCollectionView.topAnchor.constraint(equalTo:
                scrollContentView.safeAreaLayoutGuide.topAnchor,constant: 0),
            self.imagesCollectionView.leadingAnchor.constraint(equalTo:
                scrollContentView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            self.imagesCollectionView.trailingAnchor.constraint(equalTo:
                scrollContentView.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
    }

    func setupCelestialBodyDescription() {

        scrollContentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: imagesCollectionView.bottomAnchor, constant: 20),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 10),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -20),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor, constant: 20)
        ])
    }
}
