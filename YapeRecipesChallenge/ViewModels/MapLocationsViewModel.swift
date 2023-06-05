//
//  MapLocationsViewModel.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 03/06/23.
//

import Foundation
import MapKit
import Combine
import CoreLocation

protocol MapLocationsService {
    var coordinateRegion: MKCoordinateRegion { get }
    var placemark: CLPlacemark? { get }

    func searchForCity(city: String) throws -> AnyPublisher<CLLocationCoordinate2D?, Error>
}

class MapLocationsViewModel: ObservableObject, MapLocationsService {
 
    @Published var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.331516, longitude: -122.030018),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @Published var placemark: CLPlacemark?
    @Published var cityCoordinate: CLLocationCoordinate2D?

    var geocodingService: RecipeLocationGeocodingServiceProtocol
    var subscriptions = Set<AnyCancellable>()

    init(geocodingService: RecipeLocationGeocodingServiceProtocol = RecipeLocationGeocodingService()) {
        self.geocodingService = geocodingService
    }

    func searchForCity(city: String) throws -> AnyPublisher<CLLocationCoordinate2D?, Error> {
        do {
            return try geocodingService.geocodeAddressString(city)
                .map { placemark -> CLLocationCoordinate2D? in
                    if let placemark = placemark.first {
                        return placemark.location?.coordinate
                    }
                    return nil
                }
                .eraseToAnyPublisher()
        } catch {
            throw GeocodingError.invalidAddress
        }
    }
}

extension MKPointAnnotation: Identifiable {
    public var id: UUID { UUID() }
}

struct MapAnnotationModel {
    let coordinate: CLLocationCoordinate2D
    let title: String
}

extension CLLocationCoordinate2D: Identifiable {
    public var id: UUID { UUID() }
}
