//
//  URLSessionMock.swift
//  FP_UalaTests
//
//  Created by Fernando Putallaz on 02/01/2025.
//

import Foundation

class URLSessionMock: URLProtocol {
    static var mockResponse: (Data?, URLResponse?, Error?)?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let (data, response, error) = URLSessionMock.mockResponse {
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            if let response = response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let error = error {
                client?.urlProtocol(self, didFailWithError: error)
            } else {
                client?.urlProtocolDidFinishLoading(self)
            }
        }
    }
    
    override func stopLoading() {}
}
