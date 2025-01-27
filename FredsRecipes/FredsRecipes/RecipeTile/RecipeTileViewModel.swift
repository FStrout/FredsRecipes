//
//  RecipeTileViewModel.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import SwiftUI

class RecipeTileViewModel: ObservableObject {
  
  @Published var name: String = .empty
  @Binding var selectedRecipe: Recipe?
  var linkOpened: Bool = false
  
  let recipe: Recipe
  
  let applicationService: ApplicationServiceProtocol
  
  init(
    recipe: Recipe,
    selectedRecipe: Binding<Recipe?>,
    applicationService: ApplicationServiceProtocol
  ) {
    self.recipe = recipe
    self.name = recipe.name
    self._selectedRecipe = selectedRecipe
    self.applicationService = applicationService
  }
  
  // View Actions
  
  func openURL(_ urlString: String) {
    Logger.d("Open URL: \(urlString)")
    Task {
      do {
        linkOpened = try await applicationService.open(urlString)
      } catch {
        Logger.e("Error opening URL: \(error)")
      }
    }
  }
  
  func selectRecipe() {
    Logger.d("Selected \(recipe.name)")
    selectedRecipe = recipe
  }
}
