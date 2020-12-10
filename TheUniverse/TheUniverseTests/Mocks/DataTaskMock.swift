//
//  DataTaskMock.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 07/12/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
@testable import TheUniverse

class DataTaskMock: URLSessionDataTask {
    var calledResume = false
    var completion: (Data?, URLResponse?, Error?) -> Void

    init(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completion = completion
    }
    override func resume() {
        calledResume = true
        completion(nil,nil,nil)
    }
}
