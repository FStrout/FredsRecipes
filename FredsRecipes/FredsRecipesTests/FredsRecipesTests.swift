//
//  FredsRecipesTests.swift
//  FredsRecipesTests
//
//  Created by Fred Strout on 1/16/25.
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
    
    guard let path = Bundle.main.path(forResource: "MockRecipes", ofType: "json"),
          let data = FileManager.default.contents(atPath: path) else {
      assertionFailure("Failed to retrieve the json file from the bundle")
      return
    }
    
    MockURLProtocol.loadingHandler = {
      return (httpResponse, data)
    }
    
    let result = try await service.request(.recipes)
    
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
      let _ = try await service.request(.recipes)
    } catch let error as NetworkError {
      #expect(error.errorDescription == "Request Failed")
    } catch {
      assertionFailure("Failed to retrieve the expected error type.")
    }
  }
  
  func getHTTPURLResponse(_ statusCode: Int) -> HTTPURLResponse {
    return HTTPURLResponse(
      url: Endpoint.recipes.url,
      statusCode: statusCode,
      httpVersion: nil,
      headerFields: nil
    )!
  }
}

struct RecipeListViewModelTests {
  let viewModel = RecipeListViewModel(apiService: MockAPIService.shared)
  
  @Test func initialState() async throws {
    
    // expect
    #expect(!viewModel.displayEndpointButtons)
    #expect(viewModel.cuisines.isEmpty)
    #expect(viewModel.viewStatus == .loading)
  }
  
  @Test func toggleEndpointButtons() async throws {
    // engage
    viewModel.toggleEndpointButtons()
    // expect
    #expect(viewModel.displayEndpointButtons)
    
    // engage again
    viewModel.toggleEndpointButtons()
    // expect again
    #expect(!viewModel.displayEndpointButtons)
  }
  
  @Test func loadContentRecipes() async throws {
    // engage
    viewModel.loadContent(endpoint: .recipes)
    // chill
    while viewModel.viewStatus == .loading {}
    //expect
    #expect(viewModel.viewStatus == .loaded)
    #expect(!viewModel.cuisines.isEmpty)
  }
  
  @Test func loadContentEmpty() async throws {
    // engage
    viewModel.loadContent(endpoint: .empty)
    // chill
    while viewModel.viewStatus == .loading {}
    // expect
    #expect(viewModel.viewStatus == .loaded)
    #expect(viewModel.cuisines.isEmpty)
  }
  
  @Test func loadContentError() async throws {
    // engage
    viewModel.loadContent(endpoint: .malformed)
    // chill
    while viewModel.viewStatus == .loading {}
    // expect
    #expect(viewModel.viewStatus == .error)
    #expect(viewModel.cuisines.isEmpty)
  }
}

struct RecipeTileTests {
  let recipes = Bundle.main.decode(
    RecipeResponse.self,
    from: "MockRecipes.json",
    keyDecodingStrategy: .convertFromSnakeCase
  ).recipes
  
  @Test func hasNoOutsideLinks() async throws {
    // setup
    let viewModel = RecipeTileViewModel(recipe: recipes[0])
    // evaluate
    #expect(!viewModel.hasSource)
    #expect(!viewModel.hasYoutube)
    #expect(viewModel.name == "Morpheus's Slop - None")
  }
  
  @Test func hasSourceAndHasYoutube() async throws {
    // setup
    let viewModel = RecipeTileViewModel(recipe: recipes[1])
    // evaluate
    #expect(viewModel.hasSource)
    #expect(viewModel.hasYoutube)
    #expect(viewModel.name == "Morpheus's Slop - Both")
  }
  
  @Test func hasSourceAndNoYoutube() async throws {
    // setup
    let viewModel = RecipeTileViewModel(recipe: recipes[2])
    // evaluate
    #expect(viewModel.hasSource)
    #expect(!viewModel.hasYoutube)
    #expect(viewModel.name == "Morpheus's Slop - Source")
  }
  
  @Test func hasYoutubeAndNoSource() async throws {
    // setup
    let viewModel = RecipeTileViewModel(recipe: recipes[3])
    // evaluate
    #expect(!viewModel.hasSource)
    #expect(viewModel.hasYoutube)
    #expect(viewModel.name == "Morpheus's Slop - Youtube")
  }
}
