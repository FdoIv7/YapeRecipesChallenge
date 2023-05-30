//
//  RequestManagerService.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 29/05/23.
//

import Foundation

protocol RequestManagerServiceProtocol {
    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

class RequestManagerService: RequestManagerServiceProtocol {

    let apiManager: APIManagerServiceProtocol
    let parser: DataParserServiceProtocol

    init(
        apiManager: APIManagerServiceProtocol = APIManagerService(),
        parser: DataParserServiceProtocol = DataParser()
    ) {
        self.apiManager = apiManager
        self.parser = parser
    }

    func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T {
        let data = try await apiManager.perform(request)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}
