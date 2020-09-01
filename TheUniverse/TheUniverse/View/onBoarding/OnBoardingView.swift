//
//  OnBoardingView.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 27/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

class OnBoardingView: UIView {

    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.SFProRoundedTitle
        label.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
        label.textColor = .defaultGrey
        label.numberOfLines = 0
        label.text = """

        The Universe é o aplicativo ideal para quem quer se aventurar nas curiosidades do universo.

        1. Clique nos corpos celestes para ver suas informações e curiosidades.

        2. Nas imagens, passe para o lado para ver mais imagens do corpo celeste escolhido.

        3. Caso queira, clique na imagem para vê-la em fullscreen.

        """

        return label
    }()

    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("IR PARA O UNIVERSO", for: .normal)
        button.backgroundColor = .defaultGreen
        button.titleLabel!.font = UIFont.SFProRoundedTitle
        button.titleLabel!.textColor = .defaultBlack
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return button
    }()

    var dismissAction: (() -> Void)!
    @objc func dismiss() {
        dismissAction()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .defaultBlack
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {

        self.addSubview(bodyLabel)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            bodyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            bodyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])

        self.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -90),
            startButton.widthAnchor.constraint(equalTo: bodyLabel.widthAnchor, multiplier: 1),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
