//
//  RecipeResponse.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import Foundation

public struct RecipeResponse: Decodable {
  let recipes: [Recipe]
}
