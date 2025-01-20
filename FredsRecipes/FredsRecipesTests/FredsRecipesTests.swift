//
//  FredsRecipesTests.swift
//  FredsRecipesTests
//
//  Created by Fred Strout on 1/16/25.
//

import Testing
@testable import FredsRecipes

struct RecipeListViewModelTests {
  let viewModel = RecipeListViewModel()
  
  @Test func initialState() async throws {
    
    // expect
    #expect(!viewModel.displayEndpointButtons)
    #expect(viewModel.sections.isEmpty)
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
    #expect(!viewModel.sections.isEmpty)
  }
  
  @Test func loadContentEmpty() async throws {
    // engage
    viewModel.loadContent(endpoint: .empty)
    // chill
    while viewModel.viewStatus == .loading {}
    // expect
    #expect(viewModel.viewStatus == .loaded)
    #expect(viewModel.sections.isEmpty)
  }
  
  @Test func loadContentError() async throws {
    // engage
    viewModel.loadContent(endpoint: .malformed)
    // chill
    while viewModel.viewStatus == .loading {}
    // expect
    #expect(viewModel.viewStatus == .error)
    #expect(viewModel.sections.isEmpty)
  }
}

