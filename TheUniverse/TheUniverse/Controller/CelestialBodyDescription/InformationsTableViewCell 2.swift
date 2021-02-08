//
//  CelestialBodyDescriptionTableViewCell.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 08/10/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class CelestialBodyDescriptionTableViewCell: UITableViewCell {

    let celestialBodyTittleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .defaultGrey
        label.font = UIFont.SFProRoundedTitle
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    let celestialBodyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .defaultGrey
        label.font = UIFont.SFProRoundedDescription
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label
    }()

    let celestialBodyImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .defaultBlack
        image.heightAnchor.constraint(equalToConstant: 180).isActive = true
        return image
    }()

    var listOfImages: [UIImage] = []
    var indexPathForCell: Int?
    var celestialBodyName: String?
    let apiModel = ApiModel()

    override func prepareForReuse() {
        celestialBodyTittleLabel.text = ""
        celestialBodyDescriptionLabel.text = ""
        celestialBodyImage.image = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        listOfImages = []
        self.backgroundColor = .black
        self.clipsToBounds = true
        self.setupCelestialBodyTittleConstraints()
        self.setupCelestialBodyDescriptionConstraints()
        self.setupCelestialBodyImageConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCelestialBodyTittleConstraints() {
        self.addSubview(celestialBodyTittleLabel)
        celestialBodyTittleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyTittleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.celestialBodyTittleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.celestialBodyTittleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    func setupCelestialBodyDescriptionConstraints() {
        self.addSubview(celestialBodyDescriptionLabel)
        celestialBodyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyDescriptionLabel.topAnchor.constraint(
                equalTo: self.celestialBodyTittleLabel.bottomAnchor , constant: 10),
            self.celestialBodyDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.celestialBodyDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    func setupCelestialBodyImageConstraints() {
        self.addSubview(celestialBodyImage)
        celestialBodyImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyImage.topAnchor.constraint(
                equalTo: self.celestialBodyDescriptionLabel.bottomAnchor, constant: 10),
            self.celestialBodyImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.celestialBodyImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.celestialBodyImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    func setupImage() {
        let repository = Repository(filename: celestialBodyName!)
        let urlImage = repository.load()

        if let urlImages = urlImage, urlImages.urlOfCelestialBodyImages.count > indexPathForCell! {
            apiModel.fetchImage(urlString: urlImages.urlOfCelestialBodyImages[indexPathForCell!]) { image in
                DispatchQueue.main.async {
                    self.celestialBodyImage.image = image
                    self.listOfImages.append(image)
                }
            }
        } else {
            apiModel.nasaApiCall(celestialBodyNames: celestialBodyName!, indexImage: indexPathForCell!) { image in
                DispatchQueue.main.async {
                    self.celestialBodyImage.image = image
                    self.listOfImages.append(image)
                }
            }
        }
    }
}
