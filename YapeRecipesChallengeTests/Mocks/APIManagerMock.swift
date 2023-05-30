//
//  APIManagerMock.swift
//  YapeRecipesChallengeTests
//
//  Created by Fernando Ives on 29/05/23.
//

import Foundation
@testable import YapeRecipesChallenge

struct APIManagerMock: APIManagerServiceProtocol {
    func perform(_ request: RequestProtocol) async throws -> Data {
        return try Data(contentsOf: URL(filePath: request.path), options: .mappedIfSafe)
    }
}
