//
//  RecipeDetailViewModel.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/27/25.
//

import SwiftUI

class RecipeDetailViewModel: ObservableObject {
  
  @Published var recipe: Recipe
  
  let applicationService: ApplicationServiceProtocol
  var linkOpened: Bool = false
  
  init(recipe: Recipe, applicationService: ApplicationServiceProtocol) {
    self.applicationService = applicationService
    self.recipe = recipe
  }
  
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
}
