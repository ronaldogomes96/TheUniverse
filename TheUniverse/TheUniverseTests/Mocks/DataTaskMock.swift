//
//  DataTaskMock.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 07/12/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit
@testable import TheUniverse

class DataTaskMock: URLSessionDataTask {
    var mockData: TestDataTaskDataMock?
    var calledResume = false
    var completion: (Data?, URLResponse?, Error?) -> Void

    init(mockData: TestDataTaskDataMock? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completion = completion
        self.mockData = mockData
    }
    override func resume() {
        calledResume = true
        self.completion(mockData?.testData, mockData?.testResponse, mockData?.testError)
    }
}
