//
//  Recipe+Extensions.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/20/25.
//

import Foundation

extension Recipe {
  static let testRecipeBasic = Recipe(
    cuisine: "Matrix",
    name: "Morpheus's Slop",
    photoUrlLarge: .empty,
    photoUrlSmall: .empty,
    sourceUrl: nil,
    uuid: UUID().uuidString,
    youtubeUrl: nil
  )
  
  static let testRecipeWithSource = Recipe(
    cuisine: "Matrix",
    name: "Source",
    photoUrlLarge: .empty,
    photoUrlSmall: .empty,
    sourceUrl: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    uuid: UUID().uuidString,
    youtubeUrl: nil
  )
  
  static let testRecipeWithYouTube = Recipe(
    cuisine: "Matrix",
    name: "Youtube",
    photoUrlLarge: .empty,
    photoUrlSmall: .empty,
    sourceUrl: nil,
    uuid: UUID().uuidString,
    youtubeUrl: "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
  )
  
  static let testRecipeWithSourceAndYouTube = Recipe(
    cuisine: "Matrix",
    name: "Both",
    photoUrlLarge: .empty,
    photoUrlSmall: .empty,
    sourceUrl: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    uuid: UUID().uuidString,
    youtubeUrl: "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
  )
}
