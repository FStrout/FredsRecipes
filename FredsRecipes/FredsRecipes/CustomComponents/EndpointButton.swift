//
//  MainMenuButton.swift
//  FredsRecipes
//
//  Created by Fred Strout on 1/17/25.
//

import SwiftUI

struct EndpointButton: View {
  
  var label: String
  var isSelected: Bool
  
  init(_ label: String, isSelected: Bool = false) {
    self.label = label
    self.isSelected = isSelected
  }
  
  var body: some View {
    Text(label)
      .font(.system(size: .buttonFontSize))
      .fontWeight(.semibold)
      .foregroundStyle(Color.black)
      .background {
        RoundedRectangle(cornerRadius: .buttonCornerRadius)
          .fill(Color.orange.opacity(isSelected ? 0.5 : 1))
          .frame(width: .buttonWidth, height: .endpointButtonHeight)
      }
      .frame(width: .buttonWidth, height: .endpointButtonHeight)
  }
}

#Preview {
  HStack {
    EndpointButton("Recipes", isSelected: true)
    Spacer()
    EndpointButton("Empty")
    Spacer()
    EndpointButton("Malformed")
  }
  .padding(.horizontal, .spacing24)
  
}
