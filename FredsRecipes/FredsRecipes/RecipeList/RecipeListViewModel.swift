//
//  RecipeListViewModel.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import SwiftUI

final class RecipeListViewModel: ObservableObject {
  
  @Published var displayEndpointButtons: Bool = false
  @Published var cuisines: [Cuisine] = []
  @Published var viewStatus: ViewStatus = .loading
  
  var endpoint: Endpoint = .recipes
  
  let apiServiceProtocol: APIServiceProtocol
   
  init(apiService: APIServiceProtocol) {
    self.apiServiceProtocol = apiService
    loadContent()
  }
  
  // View Actions
  
  func loadContent(endpoint: Endpoint = .recipes) {
    self.displayEndpointButtons = false
    self.viewStatus = .loading
    self.cuisines.removeAll()
    self.endpoint = endpoint
    Task {
      await loadCuisines()
    }
  }
  
  func toggleEndpointButtons() {
    withAnimation {
      self.displayEndpointButtons.toggle()
    }
  }
  
  // Local Methods
  
  private func loadCuisines() async {
    do {
      let cuisines = try await apiServiceProtocol.request(endpoint)
      await MainActor.run {
        self.cuisines = cuisines
        self.viewStatus = .loaded
      }
    } catch {
      await MainActor.run {
        self.cuisines.removeAll()
        self.viewStatus = .error
      }
    }
  }
}
