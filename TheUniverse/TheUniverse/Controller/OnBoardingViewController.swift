//
//  OnBoardingViewController.swift
//  TheUniverse
//
//  Created by Ronaldo Gomes on 27/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

class OnBoardingViewController: UIViewController {

    lazy var onBoardingView: OnBoardingView = {
        let view = OnBoardingView()
        view.dismissAction = {
            self.dismiss(animated: true, completion: nil)
        }
        return view
    }()

    override func loadView() {
        super.loadView()
        self.view = onBoardingView
    }
}
