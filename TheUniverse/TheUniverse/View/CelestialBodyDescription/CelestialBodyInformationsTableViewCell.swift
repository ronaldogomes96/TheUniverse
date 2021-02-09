//
//  CelestialBodyDescriptionTableViewCell.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 08/10/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit
import AVFoundation

class CelestialBodyInformationsTableViewCell: UITableViewCell {

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

    static var celestialBodyInformationForSpeech: String = ""
    static let speechSynthesizer = AVSpeechSynthesizer()

    var viewModel: CelestialBodyInformationsViewModel! {
        didSet {
            celestialBodyTittleLabel.text = viewModel.getCelestialBodyDescriptionTittle()
            celestialBodyDescriptionLabel.text = viewModel.getCelestialBodyDescriptionString()
            CelestialBodyInformationsTableViewCell.celestialBodyInformationForSpeech +=
                viewModel.getCelestialBodyDescriptionString()

            viewModel.imageForApi(index: viewModel.indexPathForCell) { image in
                DispatchQueue.main.async {
                    self.celestialBodyImage.image = image
                }
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        layoutConfiguration()
        self.setupCelestialBodyTittleConstraints()
        self.setupCelestialBodyDescriptionConstraints()
        self.setupCelestialBodyImageConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        celestialBodyTittleLabel.text = ""
        celestialBodyDescriptionLabel.text = ""
        celestialBodyImage.image = nil
    }

    private func setupCelestialBodyTittleConstraints() {
        self.addSubview(celestialBodyTittleLabel)
        celestialBodyTittleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyTittleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.celestialBodyTittleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.celestialBodyTittleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    private func setupCelestialBodyDescriptionConstraints() {
        self.addSubview(celestialBodyDescriptionLabel)
        celestialBodyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.celestialBodyDescriptionLabel.topAnchor.constraint(
                equalTo: self.celestialBodyTittleLabel.bottomAnchor , constant: 10),
            self.celestialBodyDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.celestialBodyDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    private func setupCelestialBodyImageConstraints() {
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

    private func layoutConfiguration() {
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.selectionStyle = .none
    }

    static func setupSpeechSynthesizer() {
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string:
                                                                    self
                                                                    .celestialBodyInformationForSpeech)
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.5
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "pt-BR")
        self.speechSynthesizer.speak(speechUtterance)
    }
}
