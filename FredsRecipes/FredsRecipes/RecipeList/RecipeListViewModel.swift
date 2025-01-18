//
//  RecipeListViewModel.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import SwiftUI

final class RecipeListViewModel: ObservableObject {
  
  @Published var sections: [Cuisine] = []
  @Published var viewStatus: ViewStatus = .loading
  @Published var displayEndpointButtons: Bool = false
  
  var endpoint: Endpoint = .recipes
  
  init() {
    loadContent()
  }
  
  // View Actions
  
  func loadContent(endpoint: Endpoint = .recipes) {
    self.viewStatus = .loading
    self.sections.removeAll()
    self.endpoint = endpoint
    Task {
      await loadRecipes()
    }
  }
  
  func toggleEndpointButtons() {
    withAnimation {
      self.displayEndpointButtons.toggle()
    }
  }
  
  // Local Methods
  
  private func loadCuisines(recipes: [Recipe]) {
    let cuisines = Set(recipes.map { $0.cuisine })
    
    for cuisine in cuisines.sorted() {
      let recipesForCuisine = recipes.filter { $0.cuisine == cuisine }
      
      self.sections.append(Cuisine(cuisine: cuisine, recipes: recipesForCuisine))
    }
  }
  
  private func loadRecipes() async {
    do {
      let recipes = try await ApiService.shared.fetchRecipes(endpoint: endpoint)
      await MainActor.run {
        let recipes: [Recipe] = recipes
        loadCuisines(recipes: recipes)
        self.viewStatus = .loaded
      }
    } catch {
      await MainActor.run {
        self.viewStatus = .error
      }
    }
  }
}
