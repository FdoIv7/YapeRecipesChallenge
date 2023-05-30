//
//  DataParserService.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 27/05/23.
//

import Foundation

protocol DataParserServiceProtocol {
    func parse<T: Decodable>(data: Data) throws -> T
}

class DataParser: DataParserServiceProtocol {
    private var decoder: JSONDecoder

    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    func parse<T: Decodable>(data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw DataError.serializationError
        }
    }
}

enum DataError: Error {
    case serializationError
    case noData

    var localizedDescription: String {
        switch self {
        case .noData: return "No data"
        case .serializationError: return "Failed to parse JSON and decode data"
        }
    }
}
