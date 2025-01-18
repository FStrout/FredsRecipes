//
//  RecipeListView.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/16/25.
//

import SwiftUI

struct RecipeListView: View {
  
  @ObservedObject var viewModel: RecipeListViewModel = RecipeListViewModel()
  
  var body: some View {
    VStack(spacing: .zero) {
      HStack {
        Text("Recipes")
          .font(.title)
          .fontWeight(.heavy)
          .padding(.leading)
        
        Spacer()
        Button {
          viewModel.toggleEndpointButtons()
        } label: {
          Image(systemName: "gear")
            .resizable()
            .frame(width: .iconButtonSize, height: .iconButtonSize)
        }
        .padding(.trailing, .spacing16)
      }
      
      ScrollView {
        switch viewModel.viewStatus {
          case .loading:
          loadingView
        case .error:
          errorView
        case .loaded:
          if viewModel.sections.isEmpty { emptyView } else { loadedView }
        }
      }
      .refreshable {
        viewModel.loadContent()
      }
      
      if viewModel.displayEndpointButtons {
        HStack {
          Button {
            viewModel.loadContent()
          } label: {
            EndpointButton("Recipes", isSelected: viewModel.endpoint == Endpoint.recipes)
          }

          Spacer()
          
          Button {
            viewModel.loadContent(endpoint: .empty)
          } label: {
            EndpointButton("Empty", isSelected: viewModel.endpoint == Endpoint.empty)
          }
          
          Spacer()
          
          Button {
            viewModel.loadContent(endpoint: .malformed)
          } label: {
            EndpointButton("Malformed", isSelected: viewModel.endpoint == Endpoint.malformed)
          }
        }
        .padding([.horizontal, .top], .spacing24)
        .background(Color.gray.opacity(0.1))
        .transition(AnyTransition(.move(edge: .bottom)))
      }
    }
  }
  
  var errorView: some View {
    VStack(spacing: .spacing24) {
      Text("There was a problem loading the recipes.\nPlease try again.")
      
      Text("Pull down to try again.")
        .font(.footnote)
        .fontWeight(.semibold)
        .padding([.horizontal, .top], .spacing16)
    }
    .padding(.top, .spacing24)
  }
  
  var emptyView: some View {
    VStack(spacing: .spacing24) {
      
      Text("No recipes found")
      
      Text("Pull down to get the latest recipes.")
        .font(.footnote)
        .fontWeight(.semibold)
        .padding([.horizontal, .top], .spacing16)
    }
    .padding(.top, .spacing24)
  }
  
  var loadedView: some View {
    VStack {
      ForEach(viewModel.sections, id: \.cuisine) { section in
        LazyVStack(alignment: .leading, spacing: .zero) {
          Text(section.cuisine)
            .padding(.bottom, .spacing4)
          ScrollView(.horizontal) {
            LazyHStack(spacing: .spacing4) {
              ForEach(section.recipes, id: \.self) { recipe in
                RecipeTileView(recipe: recipe)
              }
            }
          }
        }
        .padding([.leading, .top])
      }
    }
  }
  
  var loadingView: some View {
    VStack {
      ProgressView().scaleEffect(2.0)
    }
  }
}

struct BlankView: View {
  let message: String
  
  init(_ message: String) {
    self.message = message
  }
  
  var body: some View {
    VStack(alignment: .center) {
      Spacer()
      Text(message)
      Spacer()
    }
    .frame(width: .blankViewWidth, height: .blankViewHeight)
  }
}

#if DEBUG
#Preview {
  RecipeListView()
}
#endif
