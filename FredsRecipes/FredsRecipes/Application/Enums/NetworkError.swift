//
//  NetworkError.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
  
  case requestFailed
  case malformedURL
  
  public var errorDescription: String {
    switch self {
    case .requestFailed:
      return "Request failed"
    case .malformedURL:
      return "Malformed URL"
    }
  }
}
