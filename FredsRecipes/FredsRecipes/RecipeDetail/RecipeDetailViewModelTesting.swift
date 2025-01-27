//
//  RecipeDetailViewModelTesting.swift
//  FredsRecipesTests
//
//  Created by Fred Strout on 1/27/25.
//

import Foundation
import Testing
@testable import FredsRecipes

struct RecipeDetailViewModelTesting {
  let service: MockApplicationService = MockApplicationService()
  let recipes = Bundle.main.decode(
    RecipeResponse.self,
    from: "MockRecipes.json",
    keyDecodingStrategy: .convertFromSnakeCase
  )?.recipes
  
  @Test func hasNoOutsideLinks() async throws {
    // setup
    guard let recipes else {
      assertionFailure("No recipes found")
      return
    }
    
    let viewModel = RecipeDetailViewModel(
      recipe: recipes[0],
      applicationService: service
    )
    // evaluate
    #expect(viewModel.recipe.sourceUrl == nil)
    #expect(viewModel.recipe.youtubeUrl == nil)
    #expect(viewModel.recipe.name == "Morpheus's Slop - None")
  }
  
  @Test func hasSourceAndHasYoutube() async throws {
    // setup
    guard let recipes else {
      assertionFailure("No recipes found")
      return
    }
    
    let viewModel = RecipeDetailViewModel(
      recipe: recipes[1],
      applicationService: service
    )
    // evaluate
    #expect(viewModel.recipe.sourceUrl != nil)
    #expect(viewModel.recipe.youtubeUrl != nil)
    #expect(viewModel.recipe.name == "Morpheus's Slop - Both")
  }
  
  @Test func hasSourceAndNoYoutube() async throws {
    // setup
    guard let recipes else {
      assertionFailure("No recipes found")
      return
    }
    
    let viewModel = RecipeDetailViewModel(
      recipe: recipes[2],
      applicationService: service
    )
    // evaluate
    #expect(viewModel.recipe.sourceUrl != nil)
    #expect(viewModel.recipe.youtubeUrl == nil)
    #expect(viewModel.recipe.name == "Morpheus's Slop - Source")
  }
  
  @Test func hasYoutubeAndNoSource() async throws {
    // setup
    guard let recipes else {
      assertionFailure("No recipes found")
      return
    }
    
    let viewModel = RecipeDetailViewModel(
      recipe: recipes[3],
      applicationService: service
    )
    // evaluate
    #expect(viewModel.recipe.sourceUrl == nil)
    #expect(viewModel.recipe.youtubeUrl != nil)
    #expect(viewModel.recipe.name == "Morpheus's Slop - Youtube")
  }
  
  @Test func openURLIsValid() async throws {
    // setup
    guard let recipes else {
      assertionFailure("No recipes found")
      return
    }
    
    let url = "https://www.google.com"
    
    let viewModel = RecipeDetailViewModel(
      recipe: recipes[0],
      applicationService: service
    )
    
    // execute
    viewModel.openURL(url)
    while viewModel.linkOpened == false {}
    
    // evaluate
    #expect(viewModel.linkOpened)
  }
  
  @Test func openURLIsNotValid() async throws {
    // setup
    guard let recipes else {
      assertionFailure("No recipes found")
      return
    }
    
    let url = ""
    
    let viewModel = RecipeDetailViewModel(
      recipe: recipes[0],
      applicationService: service
    )
    
    // execute
    viewModel.openURL(url)
    
    // evaluate
    #expect(!viewModel.linkOpened)
  }
}
