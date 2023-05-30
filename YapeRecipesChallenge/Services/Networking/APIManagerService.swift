//
//  APIManagerService.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 28/05/23.
//

import Foundation

protocol APIManagerServiceProtocol {
    func perform(_ request: RequestProtocol) async throws -> Data
}

class APIManagerService: APIManagerServiceProtocol {
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func perform(_ request: RequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(for: request.createURLRequest())
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<300 ~= statusCode else {
            throw NetworkError.invalidResponse
        }
        return data
    }
}
