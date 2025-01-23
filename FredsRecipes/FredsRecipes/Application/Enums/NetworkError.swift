//
//  NetworkError.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
  
  case invalidData
  case invalidResponse
  case invalidURL
  
  public var errorDescription: String {
    switch self {
    case .invalidData:
      return "Invalid data"
    case .invalidResponse:
      return "Invalid response"
    case .invalidURL:
      return "Invalid URL"
    }
  }
}
