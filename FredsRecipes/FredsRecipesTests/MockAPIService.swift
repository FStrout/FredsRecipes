//
//  MockAPIServiceProtocol.swift
//  FredsRecipesTests
//
//  Created by Fred Strout on 1/22/25.
//

import Foundation
@testable import FredsRecipes

class MockAPIService: APIServiceProtocol {
  static let shared = MockAPIService()
  
  private init() {}
  
  func fetchRecipes(_ endpoint: Endpoint) async throws -> [Cuisine] {
    switch endpoint {
    case .empty:
      return []
    case .malformed:
      throw NetworkError.invalidData
    case .recipes:
      let response = Bundle.main.decode(RecipeResponse.self, from: "MockRecipes.json", keyDecodingStrategy: .convertFromSnakeCase)
      return response?.cuisines ?? [Cuisine]()
    }
  }
}
