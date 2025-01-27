//
//  MockURLProtocol.swift
//  FredsRecipesTests
//
//  Created by Fred Strout on 1/20/25.
//

import Foundation

class MockURLProtocol: URLProtocol {
  
  static var loadingHandler: (() -> (HTTPURLResponse, Data?))?
  
  override class func canInit(with request: URLRequest) -> Bool {
    true
  }
  
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    request
  }
  
  override func startLoading() {
    guard let handler = MockURLProtocol.loadingHandler else {
      assertionFailure("Loading handler not set.")
      return
    }
    
    let (response, data) = handler()
    client?.urlProtocol(
      self,
      didReceive: response,
      cacheStoragePolicy: .notAllowed
    )
    
    if let data = data {
      client?.urlProtocol(self, didLoad: data)
    }
    client?.urlProtocolDidFinishLoading(self)
  }
  
  override func stopLoading() {}
}
