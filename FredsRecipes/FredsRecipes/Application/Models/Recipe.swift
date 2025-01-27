//
//  Recipe.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import Foundation

public struct Recipe: Decodable, Hashable, Identifiable {
  public let cuisine: String
  public let name: String
  public let photoUrlLarge: String
  public let photoUrlSmall: String
  public let sourceUrl: String?
  public let uuid: String
  public let youtubeUrl: String?

  public var id: String { uuid }
}
