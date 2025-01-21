//
//  NetworkError.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
  
  case requestFailed
  
  public var errorDescription: String {
    "Request Failed"
  }
}

func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
  guard let httpResponse = response.response as? HTTPURLResponse else {
    return response.data
  }
  
  switch httpResponse.statusCode {
  case 200..<300:
    return response.data
  default:
    throw NetworkError.requestFailed
  }
}
