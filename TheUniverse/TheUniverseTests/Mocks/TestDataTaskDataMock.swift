//
//  TestDataMock.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 07/12/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
@testable import TheUniverse
import UIKit

class TestDataTaskDataMock {
    var testData: Data?
    var testError: Error?
    var testResponse: URLResponse?

    init(data: Data?, error: Error?, response: URLResponse?) {
        self.testError = error
        self.testData = data
        self.testResponse = response
    }
}
