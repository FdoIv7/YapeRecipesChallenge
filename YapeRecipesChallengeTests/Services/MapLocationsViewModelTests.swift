//
//  MapLocationsViewModelTests.swift
//  YapeRecipesChallengeTests
//
//  Created by Fernando Ives on 05/06/23.
//

import Foundation
import XCTest
import Combine
@testable import YapeRecipesChallenge
import CoreLocation

class MapLocationsViewModelTests: XCTestCase {
    var subscriptions = Set<AnyCancellable>()
    var sut: MapLocationsService!
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_successfulCitySearch() throws {
        // Given
        let expectation = expectation(description: "Search for city")
        let city = "New York"
        let expectedCoordinate = CLLocationCoordinate2D(latitude: 40.7129822, longitude: -74.007205)
        var receivedCoordinate: CLLocationCoordinate2D?
        var receivedError: Error?
        sut = createViewModel()
        
        // When
        do {
            try sut.searchForCity(city: city)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        receivedError = error
                        XCTFail("Unexepcted error \(error)")
                    }
                    expectation.fulfill()
                }, receiveValue: { coordinate in
                    receivedCoordinate = coordinate
                })
                .store(in: &subscriptions)
        } catch {
            throw GeocodingError.invalidAddress
        }
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(
            receivedError,
            "Expected no error, but received \(GeocodingError.invalidAddress.localizedDescription)")
        XCTAssertNotNil(receivedCoordinate)
        XCTAssertEqual(receivedCoordinate?.latitude, expectedCoordinate.latitude)
        XCTAssertEqual(receivedCoordinate?.longitude, expectedCoordinate.longitude)
    }

    func test_failingCitySearch() throws {
        // Given
        let exp = expectation(description: "Invalid city")
        let city = "Invalid City"
        let expectedError = GeocodingError.geocodingFailed(error: NSError())
        var receivedCoordinate: CLLocationCoordinate2D?
        var receivedError: Error!
        sut = createViewModel()

        // When
        do {
            try sut.searchForCity(city: city)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        receivedError = error
                    }
                    exp.fulfill()
                }, receiveValue: { coordinate in
                    receivedCoordinate = coordinate
                })
                .store(in: &subscriptions)
        } catch {
            throw GeocodingError.invalidAddress
        }

        // Then
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(receivedError)
        XCTAssertEqual((receivedError as? GeocodingError)?.localizedDescription, expectedError.localizedDescription)
        XCTAssertNil(receivedCoordinate)
    }

    private func createViewModel() -> MapLocationsViewModel {
        return MapLocationsViewModel()
    }
}

