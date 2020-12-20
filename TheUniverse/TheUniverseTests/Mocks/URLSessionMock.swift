//
//  URLSessionMock.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 07/12/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit
@testable import TheUniverse

class URLSessionMock: URLSession {
    var lastUrl: URL?
    var dataTask: DataTaskMock?
    //var dowlondTask: DownloadTaskMock?
    var testDataTaskData: Data?
    var testError: Error?
    var testResponse: HTTPURLResponse?

    override func dataTask(with request: URL,
                           completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        lastUrl = request
        let testMock = TestDataTaskDataMock(data: testDataTaskData, error: testError, response: testResponse)
        dataTask = DataTaskMock(mockData: testMock, completion: completionHandler)
        return dataTask!
    }

//    override func downloadTask(with url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {
//        lastUrl = url
//        let testMock = TestMockData(data: testURLData, error: testError, response: testResponse)
//        dowlondTask = DownloadTaskMock(mockData: testMock, completion: completionHandler)
//        return dowlondTask!
//    }

}
