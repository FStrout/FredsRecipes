//
//  UIApplicationProtocol.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/27/25.
//

import SwiftUI

protocol ApplicationServiceProtocol {
  func open(_ url: String) async throws -> Bool
}

/// Default implementation of the `ApplicationServiceProtocol`.
///
class DefaultApplicationService: ApplicationServiceProtocol {
  
  func open(_ url: String) async throws -> Bool {
    
    guard let url = URL(string: url) else {
      throw NetworkError.invalidURL
    }
    
    return await UIApplication.shared.open(url)
  }
}

