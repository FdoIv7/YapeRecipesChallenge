//
//  RecipeLocationGeocodingService.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 03/06/23.
//

import Foundation
import CoreLocation
import Combine

protocol RecipeLocationGeocodingServiceProtocol {
    func geocodeAddressString(_ addressString: String) throws -> AnyPublisher<[CLPlacemark], Error>
}

class RecipeLocationGeocodingService: RecipeLocationGeocodingServiceProtocol {
    private let geocoder = CLGeocoder()

    func geocodeAddressString(_ addressString: String) throws -> AnyPublisher<[CLPlacemark], Error> {
        return Future<[CLPlacemark], Error> { [weak self] promise in
            self?.geocoder.geocodeAddressString(addressString) { placemarks, error in
                switch (placemarks, error) {
                case (_, let error?):
                    promise(.failure(GeocodingError.geocodingFailed(error: error)))
                case (let placemarks?, _):
                    promise(.success(placemarks))
                default: promise(.failure(GeocodingError.invalidAddress))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

enum GeocodingError: Error {
    case geocodingFailed(error: Error)
    case invalidAddress

    var localizedDescription: String {
        switch self {
        case .geocodingFailed: return "Geocoding Failed."
        case .invalidAddress: return "The address is not valid."
        }
    }
}
