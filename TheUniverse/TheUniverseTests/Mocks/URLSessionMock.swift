//
//  URLSessionMock.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 07/12/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
@testable import TheUniverse

class URLSessionMock: URLSession {
    var lastUrl: URL?
    var dataTask: DataTaskMock?

    override func dataTask(with request: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        lastUrl = request
        dataTask = DataTaskMock(completion: completionHandler)
        return dataTask!
    }
}
