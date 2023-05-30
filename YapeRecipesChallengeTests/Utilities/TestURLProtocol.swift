//
//  TestURLProtocol.swift
//  YapeRecipesChallengeTests
//
//  Created by Fernando Ives on 29/05/23.
//

import Foundation

/// A Class to catch all URL Protocol that returns successful response and records all requests
class TestURLProtocol: URLProtocol {
    
    /// Pass mockData
    static var mockData: Data?
    
    /// Mock a response
    static var response: HTTPURLResponse?
    
    static var error: NSError?

    /// Store stub response for testing
    static var stubbedResponse: HTTPURLResponse?
    
    /// Store lastRequest here so we can verify its contents.
    static var lastRequest: URLRequest?
    
    /// Returns true if this protocol should handle the given request (Returning true for all requests)
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    /// Alter requests on the fly
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    /// Start the request and send response back to client
    override func startLoading() {
        guard
            let client = client,
            let url = request.url,
            let response = TestURLProtocol.stubbedResponse ?? HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil) else { fatalError("Client or URL missing") }
        
        client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

        if let data = TestURLProtocol.mockData {
            client.urlProtocol(self, didLoad: data)
        }

        if let error = TestURLProtocol.error {
            client.urlProtocol(self, didFailWithError: error)
        }
        
        client.urlProtocolDidFinishLoading(self)
        
        if let stream = request.httpBodyStream {
            let bufferSize = 1024
            let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
            
            stream.open()
            
            while stream.hasBytesAvailable {
                let bytesRead = stream.read(buffer, maxLength: bufferSize)
                if bytesRead > 0 {
                    let data = Data(bytes: buffer, count: bytesRead)
                    client.urlProtocol(self, didLoad: data)
                }
            }
            
            stream.close()
            buffer.deallocate()
        }
        Self.lastRequest = request
    }
    
    /// Operation is canceled - Empty for this porpuses
    override func stopLoading() { }

    static func stubResponse(statusCode: Int, headers: [String: String]? = nil) {
        let url = URL(string: "http://test-example.com")!
        stubbedResponse = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: headers)
    }
}
