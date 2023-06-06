//
//  CLExtensions.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 04/06/23.
//

import Foundation
import MapKit

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
