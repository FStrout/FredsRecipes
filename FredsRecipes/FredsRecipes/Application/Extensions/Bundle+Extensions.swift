//
//  Bundle+Extensions.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/20/25.
//

import Foundation

extension Bundle {
  func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T? {
    
    guard let url = self.url(forResource: file, withExtension: nil) else {
      Logger.e("Failed to locate \(file) in bundle.")
      fatalError("Failed to locate \(file) in bundle.")
    }
    
    guard let data = try? Data(contentsOf: url) else {
      Logger.e("Failed to load \(file) from bundle.")
      fatalError("Failed to load \(file) from bundle.")
    }
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = dateDecodingStrategy
    decoder.keyDecodingStrategy = keyDecodingStrategy
    
    do {
      return try decoder.decode(T.self, from: data)
    } catch DecodingError.keyNotFound(let key, let context) {
      Logger.e("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
    } catch DecodingError.typeMismatch(_, let context) {
      Logger.e("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
    } catch DecodingError.valueNotFound(let type, let context) {
      Logger.e("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
    } catch DecodingError.dataCorrupted(_) {
      Logger.e("Failed to decode \(file) from bundle because it appears to be invalid JSON")
    } catch {
      Logger.e("Failed to decode \(file) from bundle: \(error.localizedDescription)")
    }
    return nil
  }
}
