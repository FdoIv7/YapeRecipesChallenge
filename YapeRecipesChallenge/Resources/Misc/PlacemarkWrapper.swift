//
//  PlacemarkWrapper.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 04/06/23.
//

import Foundation
import MapKit

struct PlacemarkWrapper: Identifiable {
    let id = UUID()
    let placemark: CLPlacemark
}
