//
//  ImageForApiResponseTests.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 08/02/21.
//  Copyright © 2021 Ronaldo Gomes. All rights reserved.
//

import UIKit
import XCTest
@testable import TheUniverse

class CelestialBodyImagesViewModelTests: XCTestCase {
    let session = URLSessionMock()

    func test_imageForApi_indexForFetchImage_returnData() {
        //Given
        let sut = CelestialBodyImagesViewModel(celestialBodyName: "Terra")

        let path = createLocalUrl(forImageNamed: "Terra")
        session.testURLData = path
        sut.apiModel = ApiModel(session: session)

        let expect = expectation(description: "nasaApi")

        //When
        sut.imageForApi(index: 2) { image in
            //XCTAssertNotNil(image)
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
