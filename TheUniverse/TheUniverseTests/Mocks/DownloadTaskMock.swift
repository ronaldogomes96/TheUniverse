//
//  DownloadTaskMock.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 17/12/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit
@testable import TheUniverse

class DownloadTaskMock: URLSessionDownloadTask {
    var mockData: TestDownloadTaskDataMock?
    var calledResume = false
    var completion: (URL?, URLResponse?, Error?) -> Void
    
    init(mockData: TestDownloadTaskDataMock? = nil, completion: @escaping (URL?, URLResponse?, Error?) -> Void) {
        self.completion = completion
        self.mockData = mockData
    }
    
    override func resume() {
        calledResume = true
        completion(mockData?.testData, mockData?.testResponse, mockData?.testError)
    }
}
