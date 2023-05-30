//
//  MockURLSession.swift
//  YapeRecipesChallengeTests
//
//  Created by Fernando Ives on 29/05/23.
//

import Foundation

//class MockURLSession: URLSession {
//    private let mockDataTask: MockURLSessionDataTask
//
//    init(data: Data?, response: URLResponse?, error: Error?) {
//        let mockResponse = (response as? HTTPURLResponse) ?? HTTPURLResponse()
//        let mockError = (error as? NSError) ?? NSError()
//        let mockURLSessionDataTask = MockURLSessionDataTask()
//
//        mockDataTask = mockURLSessionDataTask
//        mockDataTask.completionHandler = (data, mockResponse, mockError)
//    }
//}
//
//class MockURLSessionDataTask: URLSessionTask {
//    private let completionHandler: (Data?, URLResponse?, Error?) -> Void
//
//    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
//        super.init()
//        self.completionHandler = completionHandler
//    }
//}
