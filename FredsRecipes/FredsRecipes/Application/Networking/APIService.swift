//
//  ApiService.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import Foundation

class APIService {
  static let shared = APIService()
  
  let session: URLSession
  let decoder: JSONDecoder
  
  init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
    self.session = session
    self.decoder = decoder
    decoder.keyDecodingStrategy = .convertFromSnakeCase
  }
  
  func request(_ endpoint: Endpoint) async throws -> [Cuisine] {
    let request = URLRequest(url: endpoint.url)
    
    let (data, response) = try await session.data(for: request)
    
    let decodedResponse = try decoder.decode(RecipeResponse.self, from: try mapResponse(response: (data, response)))
    
    return loadCuisines(recipes: decodedResponse.recipes)
  }
  
  private func loadCuisines(recipes: [Recipe]) -> [Cuisine] {
    var results = [Cuisine]()
    let cuisines = Set(recipes.map { $0.cuisine })
    
    for cuisine in cuisines.sorted() {
      let recipesForCuisine = recipes.filter { $0.cuisine == cuisine }
      
      results.append(Cuisine(cuisine: cuisine, recipes: recipesForCuisine))
    }
    
    return results
  }
}
