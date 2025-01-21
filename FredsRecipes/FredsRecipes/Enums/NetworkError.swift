//
//  NetworkError.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
  
  case missingRequiredFields(String)
  case invalidParameters(operation: String, parameters: [Any])
  case badRequest
  case unauthorized
  case paymentRequired
  case forbidden
  case notFound
  case requestEntityTooLarge
  case unprocessableEntity
  case http(httpResponse: HTTPURLResponse, data: Data)
  case invalidResponse(Data)
  case deleteOperationFailed(String)
  case network(URLError)
  case unknown(Error?)
  
  public var errorDescription: String? {
    switch self {
    case .missingRequiredFields(let message):
      return message
    case .invalidParameters(operation: let operation, parameters: let parameters):
      return "Invalid parameters for operation '\(operation)': \(parameters)"
    case .http(httpResponse: let response, data: _):
      return "HTTP \(response.statusCode)"
    case .badRequest:
      return "Bad Request"
    case .unauthorized:
      return "Unauthorized"
    case .paymentRequired:
      return "Payment Required"
    case .forbidden:
      return "Forbidden"
    case .notFound:
      return "Not Found"
    case .requestEntityTooLarge:
      return "Request Entity Too Large"
    case .unprocessableEntity:
      return "Unprocessable Entity"
    case .invalidResponse(_):
      return "Invalid Response"
    case .deleteOperationFailed(let message):
      return "Delete operation failed: \(message)"
    case .network(let urlError):
      return "Network Error: \(urlError.localizedDescription)"
    case .unknown(let underlyingError):
      return "Unknonw Error: \(String(describing: underlyingError))"
    }
  }
}

func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
  guard let httpResponse = response.response as? HTTPURLResponse else {
    return response.data
  }
  
  switch httpResponse.statusCode {
  case 200..<300:
    return response.data
  case 400:
    throw NetworkError.badRequest
  case 401:
    throw NetworkError.unauthorized
  case 403:
    throw NetworkError.forbidden
  case 404:
    throw NetworkError.notFound
  case 413:
    throw NetworkError.requestEntityTooLarge
  default:
    throw NetworkError.http(httpResponse: httpResponse, data: response.data)
  }
}
