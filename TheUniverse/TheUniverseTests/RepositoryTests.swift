//
//  RepositoryTests.swift
//  TheUniverseTests
//
//  Created by Ronaldo Gomes on 30/12/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
@testable import TheUniverse
import XCTest

class RepositoryTests: XCTestCase {

    func mockSave(_ arrayInt: [Int], _ sut: Repository ) {

        let jsonData = try? JSONEncoder().encode(arrayInt)
        try? jsonData!.write(to: sut.urlPath)
    }

    override func tearDown() {
        let repository = Repository(filename: "test")
        try? FileManager.default.removeItem(at: repository.urlPath)
    }

    func test_repository_createFilePath_returnsTrue() {

        //Given
        let sut = Repository(filename: "test")

        //When
        let path = sut.urlPath

        //Then
        XCTAssertTrue(path.isFileURL)
    }

    func test_repository_saveCosmosImageName_returnsTrue() {

        //Given
        let sut = Repository(filename: "test")

        //When
        let save = sut.save("cosmos")

        //Then
        XCTAssertTrue(save)
    }

    func test_repository_loadCelestialBodyImagesStruct_returnsNotNil() {

        //Givem
        let sut = Repository(filename: "test")
        _ = sut.save("cosmos")

        //When
        let load = sut.load()

        //Then
        XCTAssertNotNil(load)
    }

    func test_repository_loadWrongStruct_returnsNil() {

        //Given
        let sut = Repository(filename: "test")
        let interactionWrong = [1, 2, 4]

        //When
        self.mockSave(interactionWrong, sut)
        let load = sut.load()

        //Then
        XCTAssertNil(load)
    }
}
