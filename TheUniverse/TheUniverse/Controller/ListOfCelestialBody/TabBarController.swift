//
//  TabBarController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 04/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

   var viewModel = TabBarViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        configureLayout()
        updateTableViewController()
    }

    func updateTableViewController() {
        for (index, viewController) in viewControllers!.enumerated() {
            guard let navigation = viewController as? UINavigationController,
                  let tableViewController = navigation.viewControllers.first as? CelestialBodyTableViewController else {
                fatalError("Unexpected Segue Identifier")
            }
            tableViewController.celestialBodyNames =
                viewModel.getInformationsFromCelestialBody(indexOf: index).0
            tableViewController.celestialBodyImageNames =
                viewModel.getInformationsFromCelestialBody(indexOf: index).1
        }
    }

    func configureLayout() {
        view.backgroundColor = .clear
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .defaultBlack
    }
}
