//
//  ARButtonController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 12/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import UIKit

class ARButtonSection: UITableViewCell {

    let arButton: UIButton = {
        let button = UIButton()
        button.setTitle("3D", for: .normal)
        button.setTitleColor(.defaultBlack, for: .normal)
        button.titleLabel!.font = UIFont.SFProRoundedTitle
        button.titleLabel!.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .defaultGreen
        button.layer.cornerRadius = 7.5
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayoutConfigurations()
        setupArButtonConstraints()

        arButton.addTarget(self,
                           action: #selector(buttonAction(_:)),
                           for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonAction(_ sender: UIButton!) {
        print("Button tapped")
    }

    private func setupArButtonConstraints() {
        self.addSubview(arButton)
        arButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            arButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            arButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            arButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            arButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            arButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupLayoutConfigurations() {
        self.contentView.isUserInteractionEnabled = false
        self.backgroundColor = .clear
    }
}
