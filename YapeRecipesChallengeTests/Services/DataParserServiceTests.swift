//
//  DataParserServiceTests.swift
//  YapeRecipesChallengeTests
//
//  Created by Fernando Ives on 27/05/23.
//

import XCTest
@testable import YapeRecipesChallenge

final class DataParserServiceTests: XCTestCase {

    var sut: DataParserServiceProtocol!

    override func setUp() {
        super.setUp()
    }

    func createService() -> DataParserServiceProtocol {
        return DataParser()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func getMockData() -> String {
        let jsonRecipe =
        """
        {
            "name": "Pizza Margherita",
            "country": "Italy"
        }
        """
        return jsonRecipe
    }

    func getInvalidMockData() -> String {
        let jsonRecipe =
        """
        {
            "name": "Pizza Margherita",
            "country": "Italy",
            "size": "five"
        }
        """
        return jsonRecipe
    }

    func test_successfulParse() {
        // Given
        let exp = expectation(description: "Data successfully parsed")
        let data = getMockData().data(using: .utf8)!
        var recipeResult: SimpleRecipe!
        sut = createService()

        // When
        do {
            let recipe: SimpleRecipe = try sut.parse(data: data)
            recipeResult = recipe
            exp.fulfill()
        } catch {
            XCTFail("Unexpected Error: \(error)")
        }

        // Then
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(recipeResult)
        XCTAssertEqual(recipeResult.country, "Italy")
        XCTAssertEqual(recipeResult.name, "Pizza Margherita")
    }

    func test_failParse() {
        // Given
        let exp = expectation(description: "Data parsing failed")
        let data = getInvalidMockData().data(using: .utf8)!
        var errorResult: Error!
        sut = createService()

        // When
        XCTAssertThrowsError(try sut.parse(data: data) as SimpleRecipe) { error in
            errorResult = error
            exp.fulfill()
        }
        
        // Then
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(errorResult)
        XCTAssertEqual(errorResult as? DataError, DataError.serializationError)
    }
}

// Testing Struct
struct SimpleRecipe: Codable {
    let name: String
    let country: String
    let size: Int?
}
