//
//  HomeView.swift
//  Portion
//
//  Created by David Amedeka on 5/16/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var linkToRecipe: String
    @Binding var servingsCountInput: String
    @Binding var servingsCount: Int
    @Environment(FoodViewModel.self) private var viewModel
    @Binding var navigationState: NavigationState
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                Group {
                    Text("Link to Recipe")
                        .subTitle()
                    Text("Enter a link to the recipe starting with http:// or https://")
                        .subTitleSupportText()
                }
                TextFieldUI(text: $linkToRecipe, prompt: "http://")
                
                Text("Number of Servings")
                    .subTitle()
                
                Text("Enter the desired amount of servings. ")
                    .subTitleSupportText()

                TextFieldUI(text: $servingsCountInput, prompt: "Number of Servings")
                .keyboardType(.numberPad)
                .onChange(of: servingsCountInput) {
                    if let intValue = Int(servingsCountInput) {
                        servingsCount = intValue
                    } else {
                        servingsCount = 1
                    }
                }
                
                Button {
                    viewModel.isLoading = true
                    viewModel.isRecipeLoaded = false
                    navigationState = .loading
                } label: {
                    UniversalButton(color: .blue, text: "Submit", textColor: .white)
                }
            }
            .navigationTitle("Enter Recipe Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HomeView(linkToRecipe: .constant(""), servingsCountInput: .constant(""), servingsCount: .constant(1), navigationState: .constant(.home))
        .environment(FoodViewModel())
}
