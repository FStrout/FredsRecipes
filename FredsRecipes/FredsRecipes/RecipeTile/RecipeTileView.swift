//
//  RecipeTile.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import SwiftUI

struct RecipeTileView: View {
  @ObservedObject var viewModel: RecipeTileViewModel
  
  init(recipe: Recipe) {
    self.viewModel = RecipeTileViewModel(recipe: recipe)
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: .spacing4) {
      Text(viewModel.recipe.name)
        .font(.system(size: .spacing12))
        .frame(height: .spacing30, alignment: .bottom)
        .padding(.leading, .spacing8)
      HStack {
        Spacer()
        CacheAsyncImage(url: URL(string: viewModel.recipe.photoUrlSmall)) { phase in
          switch phase {
          case .empty:
            Image(systemName: "photo")
              .resizable()
              .frame(width: .imageSize, height: .imageSize)
          case .success(let image):
            image
            .resizable()
            .frame(width: .imageSize, height: .imageSize)
          case .failure:
            Image(systemName: "photo")
              .resizable()
              .frame(width: .imageSize, height: .imageSize)
          @unknown default:
            fatalError()
          }
        }
        Spacer()
      }
      HStack {
        if viewModel.hasSource {
          Button {
            viewModel.openWebSite(viewModel.recipe.sourceUrl)
          } label: {
            Image(systemName: "globe")
          }
          .padding(.leading, .spacing2)
        }
        
        Spacer()
        
        if viewModel.hasYoutube {
          Button {
            viewModel.openVideo(viewModel.recipe.youtubeUrl)
          } label: {
            Image(systemName: "play.rectangle.fill")
              .foregroundStyle(Color.red)
          }
          .padding(.trailing, .spacing2)
        }
      }
      .frame(height: .spacing16, alignment: .top)
      .padding(.leading, .spacing6)
      .padding(.bottom, .spacing2)
      
    }
    .padding(.vertical, .spacing4)
    .frame(width: .spacing128)
  }
}

#if DEBUG
#Preview {
  RecipeTileView(recipe: .canvasRecipe)
}
#endif
