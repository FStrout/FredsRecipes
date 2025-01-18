//
//  ApiService.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import Foundation

class ApiService {
  static let shared = ApiService()
  
  func fetchRecipes(endpoint: Endpoint) async throws -> [Recipe] {
    let url = URL(string: endpoint.rawValue)
    let request = URLRequest(url: url!)
    let (data, response) = try await URLSession.shared.data(for: request)
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let recipeResponse = try decoder.decode(RecipeResponse.self, from: try mapResponse(response: (data, response)))
    
    return recipeResponse.recipes
  }
}
