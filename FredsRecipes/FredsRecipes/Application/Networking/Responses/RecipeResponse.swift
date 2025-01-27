//
//  RecipeResponse.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import Foundation

public struct RecipeResponse: Decodable {
  let recipes: [Recipe]
  
  var cuisines: [Cuisine] {
    var results = [Cuisine]()
    let cuisineSet = Set(recipes.map { $0.cuisine })
    
    cuisineSet.sorted().forEach { cuisine in
      let recipesForCuisine = recipes.filter { $0.cuisine == cuisine }
      results.append(Cuisine(cuisine: cuisine, recipes: recipesForCuisine))
    }
    return results
  }
}
