//
//  MockApplicationService.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/27/25.
//

import Foundation
@testable import FredsRecipes

class MockApplicationService: ApplicationServiceProtocol {
  var functions = [String]()
  
  func open(_ url: String) async throws -> Bool {
    guard URL(string: url) != nil else {
      throw NetworkError.invalidURL
    }
    return true
  }
}
