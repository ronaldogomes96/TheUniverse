//
//  ApiModelTests.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 09/12/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import XCTest
@testable import TheUniverse

class ApiModelTests: XCTestCase {

    func test_nasaApiCall_urlForEarthImages_toBeValid() {
        //Given
        let sut = ApiModel()
        let url = URL(string: "https://images-api.nasa.gov/search?q=earth&media_type=image")
        let session = URLSessionMock()

        let expect = expectation(description: "nasaApi")

        //When
        sut.nasaApiCall(celestialBodyNames: "Terra", indexImage: 1, session: session) { result in
            //Then
            XCTAssertEqual(url, session.lastUrl)
            expect.fulfill()
        }

        wait(for: [expect], timeout: 5)
    }
    
    func test_nasaApiCall_urlForEarthImages_resumeCalled() {
        //Given
        let sut = ApiModel()
        let session = URLSessionMock()
        
        let expect = expectation(description: "nasaApi")
        
        //When
        sut.nasaApiCall(celestialBodyNames: "Terra", indexImage: 1, session: session) { result in
            //Then
            XCTAssertTrue(session.dataTask?.calledResume ?? false)
            expect.fulfill()
        }

        wait(for: [expect], timeout: 5)
    }

}
