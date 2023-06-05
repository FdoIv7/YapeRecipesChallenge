//
//  CLPlacemark+Extensions.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 04/06/23.
//

import Foundation
import MapKit

extension CLPlacemark: Identifiable {
    public var id: UUID { UUID() }
}
