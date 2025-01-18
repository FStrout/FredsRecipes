//
//  CacheAsyncImage.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/17/25.
//
// This was adapted from a 'Swift and Tips' YouTube video:
// https://youtu.be/KhGyiOk3Yzk?si=P4DCXPnAnsyIlmR3

import SwiftUI

struct CacheAsyncImage<Content: View>: View {
  
  private let url: URL?
  private let scale: CGFloat
  private let transaction: Transaction
  private let content: (AsyncImagePhase) -> Content
  
  init(
    url: URL?,
    scale: CGFloat = 1.0,
    transaction: Transaction = Transaction(),
    @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
  ) {
    self.url = url
    self.scale = scale
    self.transaction = transaction
    self.content = content
  }
  
  var body: some View {
    if let url, let cached = ImageCache[url] {
      content(.success(cached))
    } else {
      AsyncImage(
        url: url,
        scale: scale,
        transaction: transaction
      ) { phase in
        cacheImageAndDisplay(phase)
      }
    }
  }
  
  func cacheImageAndDisplay(_ phase: AsyncImagePhase) -> some View {
    if case .success(let image) = phase {
      if let url { ImageCache[url] = image }
    }
    return content(phase)
  }
}

fileprivate class ImageCache {
  static private var cache: [URL: Image] = [:]
  
  static subscript (url: URL) -> Image? {
    get { cache[url] }
    set { cache[url] = newValue }
  }
}

#Preview {
  CacheAsyncImage(
    url: .testImageUrl
  ) { phase in
    switch phase {
    case .empty:
      ProgressView()
    case .success(let image):
      image
        .resizable()
        .frame(width: 200, height: 200)
    case .failure:
      Text("Error")
    @unknown default:
      fatalError()
    }
  }
    
}
