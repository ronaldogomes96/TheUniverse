//
//  TabBarViewController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 14/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    var celestialBody = CelestialBodyModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        view.backgroundColor = .clear
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .defaultBlack
        updatePage()
    }

    func updatePage() {
        for (index, viewController) in viewControllers!.enumerated() {
            guard let navigation = viewController as? UINavigationController,
                let tableViewController = navigation.viewControllers.first as? CelestialBodyTableViewController else {
                    fatalError("Unexpected Segue Identifier")
            }

            switch index {
            case 0:
                tableViewController.celestialBodyNames =
                    celestialBody.getListOfNamesAndImagesOfCelestialBody(from: .planets)?.0
                tableViewController.celestialBodyImageNames =
                    celestialBody.getListOfNamesAndImagesOfCelestialBody(
                    from: .planets)?.1

            case 1:
                tableViewController.celestialBodyNames =
                    celestialBody.getListOfNamesAndImagesOfCelestialBody(from: .satellites)?.0
                tableViewController.celestialBodyImageNames =
                    celestialBody.getListOfNamesAndImagesOfCelestialBody(from: .satellites)?.1

            case 2:
                tableViewController.celestialBodyNames =
                    celestialBody.getListOfNamesAndImagesOfCelestialBody(from: .stars)?.0
                tableViewController.celestialBodyImageNames =
                    celestialBody.getListOfNamesAndImagesOfCelestialBody(from: .stars)?.1

            default:
                fatalError("Unexpected Segue Identifier")
            }
        }
    }
}
