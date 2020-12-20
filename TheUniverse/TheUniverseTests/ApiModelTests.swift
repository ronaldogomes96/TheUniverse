//
//  ApiModelTests.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 09/12/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import XCTest
import Foundation
@testable import TheUniverse

class ApiModelTests: XCTestCase {
    let session = URLSessionMock()

    // MARK: - NasaApiCall
    
    func test_nasaApiCall_urlForEarthImages_toBeValid() {
        //Given
        let sut = ApiModel(session: session)
        let url = URL(string: "https://images-api.nasa.gov/search?q=earth&media_type=image")

        let expect = expectation(description: "nasaApi")

        //When
        sut.nasaApiCall(celestialBodyNames: "Terra", indexImage: 1) { _ in
            //Then
            XCTAssertEqual(url, self.session.lastUrl)
            expect.fulfill()
        }

        wait(for: [expect], timeout: 5)
    }

    func test_nasaApiCall_urlForEarthImages_resumeCalled() {
        //Given
        let sut = ApiModel(session: session)

        let expect = expectation(description: "nasaApi")

        //When
        sut.nasaApiCall(celestialBodyNames: "Terra", indexImage: 1) { _ in
            //Then
            XCTAssertTrue(self.session.dataTask?.calledResume ?? false)
            expect.fulfill()
        }

        wait(for: [expect], timeout: 5)
    }

    func test_nasaApiCall_urlForEarthImages_returnData() {
        //Given
        let sut = ApiModel(session: session)
        let response = Response(collection:
                                    Collection(items:
                                                [Items(links:
                                                        [Links(href:
                                                                "https://images-api.nasa.gov/search?q=earth&media_type=image")])]))

        session.testDataTaskData = try? JSONEncoder().encode(response)
        let expect = expectation(description: "nasaApi")

        //When
        sut.nasaApiCall(celestialBodyNames: "Terra",
                        indexImage: 0,
                        fecthImage: ApiModelMock().fetchImage(urlString:completion:)) { image in
            XCTAssertNotNil(image)
            expect.fulfill()
        }

        wait(for: [expect], timeout: 5)
    }

    func test_nasaApiCall_urlForEarthImages_returnsError() {
        //Given
        let sut = ApiModel(session: session)

        let expect = expectation(description: "nasaApi")

        //When
        sut.nasaApiCall(celestialBodyNames: "Terra",
                        indexImage: 0,
                        fecthImage: ApiModelMock().fetchImage(urlString:completion:)) { image in
            XCTAssertNil(image)
            expect.fulfill()
        }

        wait(for: [expect], timeout: 5)
    }

    // MARK: - FetchImage

    func test_fetchImage_urlForEarthImages_toBeValid() {
        //Given
        let sut = ApiModel(session: session)
        let url = URL(string: "https://images-api.nasa.gov/search?q=earth&media_type=image")

        let expect = expectation(description: "nasaApi")

        //When
        sut.fetchImage(urlString: url!.absoluteString) { _ in
            //Then
            XCTAssertEqual(url, self.session.lastUrl)
            expect.fulfill()
        }

        wait(for: [expect], timeout: 5)
    }

    func test_fecthImage_urlForEarthImages_resumedCalled() {
        //Given
        let sut = ApiModel(session: session)
        let url = URL(string: "https://images-api.nasa.gov/search?q=earth&media_type=image")

        let expect = expectation(description: "nasaApi")

        //When
        sut.fetchImage(urlString: url!.absoluteString) { _ in
            XCTAssertTrue(self.session.dowlondTask?.calledResume ?? false)
            expect.fulfill()
        }

        wait(for: [expect], timeout: 5)
    }

    func test_fetchImage_urlForEarthImages_returnData() {
        //Given
        let sut = ApiModel(session: session)
        let url = URL(string: "https://images-api.nasa.gov/search?q=earth&media_type=image")
        let path = createLocalUrl(forImageNamed: "Terra")
        session.testURLData = path
        let expect = expectation(description: "nasaApi")

        //When
        sut.fetchImage(urlString: url!.absoluteString) { image in
            XCTAssertNotNil(image)
            expect.fulfill()
        }

        wait(for: [expect], timeout: 5)
    }

    func test_fetchImage_urlForEarthImages_returnError() {
        //Given
        let sut = ApiModel(session: session)
        let expect = expectation(description: "nasaApi")
        let url = URL(string: "https://images-api.nasa.gov/search?q=earth&media_type=image")

        //When
        sut.fetchImage(urlString: url!.absoluteString) { image in
            XCTAssertNil(image)
            expect.fulfill()
        }

        wait(for: [expect], timeout: 5)
    }

    // MARK: - Help Functions

    func createLocalUrl(forImageNamed name: String) -> URL? {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")

        guard fileManager.fileExists(atPath: url.path) else {
            guard
                let image = UIImage(named: name),
                let data = image.jpegData(compressionQuality: 1.0)
            else { return nil }

            fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
            return url
        }

        return url
    }
}
