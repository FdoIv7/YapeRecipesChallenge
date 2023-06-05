//
//  Data+Extensions.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 30/05/23.
//

import Foundation

extension Data {
    public func transforming<T>(type: T.Type) throws -> T where T: Decodable {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
