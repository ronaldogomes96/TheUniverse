//
//  ApiModelMock.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 18/12/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit
@testable import TheUniverse

class ApiModelMock: ApiModel {
    override func fetchImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        completion(UIImage(named: "Terra"))
    }
}
