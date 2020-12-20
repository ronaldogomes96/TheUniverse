//
//  TestDownloadTaskDataMock.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 20/12/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation

class TestDownloadTaskDataMock {
    var testData: URL?
    var testError: Error?
    var testResponse: URLResponse?

    init(data: URL?, error: Error?, response: URLResponse?) {
        self.testError = error
        self.testData = data
        self.testResponse = response
    }
}
