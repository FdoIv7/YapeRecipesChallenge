//
//  RequestProtocol.swift
//  YapeRecipesChallenge
//
//  Created by Fernando Ives on 28/05/23.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?] { get }
    var requestType: RequestType { get }
    func createURLRequest() throws -> URLRequest
}

/// Default implementation for RequestProtocol

extension RequestProtocol {
    var host: String {
        Constants.Networking.baseURL
    }

    var path: String {
        Constants.Networking.Endpoints.recipes
    }

    var headers: [String: String] {
        [:]
    }

    var params: [String: Any] {
        [:]
    }

    var urlParams: [String: String?] {
        [:]
    }

    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "demo4677561.mockable.io"
        components.path = path

        if !urlParams.isEmpty {
            components.queryItems = urlParams.map({
                URLQueryItem(name: $0, value: $1)
            })
        }

        guard
            let url = components.url ?? URL(string: "https://demo4677561.mockable.io/recipes_world")
        else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue

        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }

        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        return urlRequest
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse

    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "The server returned with a bad response."
        }
    }
}
