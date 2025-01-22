//
//  ApiService.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import Foundation

protocol APIServiceProtocol {
  func request(_ endpoint: Endpoint) async throws -> [Cuisine]
}

class DefaultAPIService: APIServiceProtocol {
  
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
    
    return decodedResponse.cuisines
  }
}
