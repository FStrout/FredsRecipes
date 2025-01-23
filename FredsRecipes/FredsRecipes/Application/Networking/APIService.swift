//
//  ApiService.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import Foundation

protocol APIServiceProtocol {
  func fetchRecipes(_ endpoint: Endpoint) async throws -> [Cuisine]
}

class DefaultAPIService: APIServiceProtocol {
  
  let session: URLSession
  let decoder: JSONDecoder
  
  init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
    self.session = session
    self.decoder = decoder
    decoder.keyDecodingStrategy = .convertFromSnakeCase
  }
  
  func fetchRecipes(_ endpoint: Endpoint) async throws -> [Cuisine] {
    guard let url = endpoint.url else {
      throw NetworkError.invalidURL
    }
    
    let request = URLRequest(url: url)
    
    let (data, response) = try await session.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw NetworkError.invalidResponse
    }
    
    do {
      let decodedResponse = try decoder.decode(RecipeResponse.self, from: data)
      
      return decodedResponse.cuisines
    } catch {
      throw NetworkError.invalidData
    }
  }
}
