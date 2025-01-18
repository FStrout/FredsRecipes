//
//  RecipeTileViewModel.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import SwiftUI

class RecipeTileViewModel: ObservableObject {
  
  @Published var name: String = .empty
  @Published var hasSource: Bool = false
  @Published var hasYoutube: Bool = false
  
  let recipe: Recipe
  
  init(recipe: Recipe) {
    self.recipe = recipe
    self.name = recipe.name
    self.hasSource = recipe.sourceUrl != nil
    self.hasYoutube = recipe.youtubeUrl != nil
  }
  
  // View Actions
  
  func openWebSite(_ webSite: String?) {
    guard let webSite, let webSiteUrl = URL(string: webSite) else { return }
    
    UIApplication.shared.open(webSiteUrl)
  }
  
  func openVideo(_ video: String?) {
    guard let video, let videoUrl = URL(string: video) else { return }
    
    UIApplication.shared.open(videoUrl)
  }
}
