//
//  NetworkErrorTests.swift
//  FredsRecipesTests
//
//  Created by Fred Strout on 1/27/25.
//

import Testing
@testable import FredsRecipes

struct NetworkErrorTests {
  @Test func invalidData() {
    let error = NetworkError.invalidData
    #expect(error.errorDescription == "Invalid data")
  }
  
  @Test func invalidResponse() {
    let error = NetworkError.invalidResponse
    #expect(error.errorDescription == "Invalid response")
  }
  
  @Test func invalidURL() {
    let error = NetworkError.invalidURL
    #expect(error.errorDescription == "Invalid URL")
  }
}
