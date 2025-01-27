//
//  APIServiceTests.swift
//  FredsRecipesTests
//
//  Created by Fred Strout on 1/27/25.
//

import Foundation
import Testing
@testable import FredsRecipes

struct APIServiceTests {
  
  private var session: URLSession = {
    let config = URLSessionConfiguration.ephemeral
    config.protocolClasses = [MockURLProtocol.self]
    return URLSession(configuration: config)
  }()
  
  @Test func requestSuccess() async throws {
    let service: DefaultAPIService = DefaultAPIService(session: session)
    let httpResponse = getHTTPURLResponse(200)
    
    guard let path = Bundle.main.path(
      forResource: "MockRecipes",
      ofType: "json"
    ),
    let data = FileManager.default.contents(atPath: path) else {
      assertionFailure("Failed to retrieve the json file from the bundle")
      return
    }
    
    MockURLProtocol.loadingHandler = {
      return (httpResponse, data)
    }
    
    let result = try await service.fetchRecipes(.recipes)
    
    #expect(result.count == 1)
    #expect(result[0].recipes.count == 4)
  }
  
  @Test func requestBadRequest() async {
    let service: DefaultAPIService = DefaultAPIService(session: session)
    let httpResponse = getHTTPURLResponse(400)
    
    MockURLProtocol.loadingHandler = {
      return (httpResponse, nil)
    }
    
    do {
      let _ = try await service.fetchRecipes(.recipes)
    } catch let error as NetworkError {
      #expect(error.errorDescription == "Invalid response")
    } catch {
      assertionFailure("Failed to retrieve the expected error type.")
    }
  }
  
  func getHTTPURLResponse(_ statusCode: Int) -> HTTPURLResponse {
    return HTTPURLResponse(
      url: Endpoint.recipes.url!,
      statusCode: statusCode,
      httpVersion: nil,
      headerFields: nil
    )!
  }
}
