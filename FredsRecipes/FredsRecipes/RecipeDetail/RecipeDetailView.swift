//
//  RecipeDetail.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/27/25.
//

import SwiftUI

struct RecipeDetailView: View {
  
  @ObservedObject var viewModel: RecipeDetailViewModel
  
  init(recipe: Recipe) {
    self.viewModel = RecipeDetailViewModel(
      recipe: recipe,
      applicationService: DefaultApplicationService()
    )
  }
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: .spacing8) {
        HStack {
          Spacer()
          CacheAsyncImage(
            url: URL(
              string: viewModel.recipe.photoUrlLarge
            )
          ) { phase in
            switch phase {
            case .empty:
              ProgressView()
            case .success(let image):
              image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 300, height: 300)
            case .failure:
              Image(systemName: "photo.badge.exclamationmark")
                .resizable()
                .frame(width: .spacing96, height: .spacing64)
                .foregroundStyle(Color.red)
            @unknown default:
              fatalError()
            }
          }
          Spacer()
        }
        .padding(.top, .spacing32)
        dataField(title: "Recipe", value: viewModel.recipe.name)
        dataField(title: "Cuisine", value: viewModel.recipe.cuisine)
        
        if let webAddress = viewModel.recipe.sourceUrl {
          dataField(title: "Recipe URL", value: webAddress, isLink: true)
            .onTapGesture {
              viewModel.openURL(webAddress)
            }
        }
        if let youtube = viewModel.recipe.youtubeUrl {
          dataField(title: "Youtube Video", value: youtube, isLink: true)
            .onTapGesture {
              viewModel.openURL(youtube)
            }
        }
      }
      .padding(.horizontal, .spacing32)
    }
  }
  
  func dataField(
    title: String,
    value: String,
    isLink: Bool = false
  ) -> some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.system(size: 12))
      if isLink {
        Text(value)
          .font(.system(size: 18, weight: .bold))
          .foregroundColor(.blue)
          .underline()
      } else {
        Text(value)
          .font(.system(size: 18, weight: .bold))
      }
    }
  }
}

#Preview {
  if let recipes = Bundle.main.decode(
    RecipeResponse.self,
    from: "MockRecipes.json",
    keyDecodingStrategy: .convertFromSnakeCase
  ) {
    RecipeDetailView(recipe: recipes.recipes[0])
  }
}
