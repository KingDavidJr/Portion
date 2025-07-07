//
//  LoadingView.swift
//  Portion
//
//  Created by David Amedeka on 5/16/25.
//

import SwiftUI

struct LoadingView: View {
    @Binding var linkToRecipe: String
    @Binding var navigationState: NavigationState
    @Environment(FoodViewModel.self) private var viewModel
    var body: some View {
        VStack {
            ProgressView("Loading...")
                .progressViewStyle(.circular)
                .tint(.blue)
                .padding()
            
        }
        .onAppear {
            Task {
                await viewModel.getRecipe(from: linkToRecipe)                
                if viewModel.isRecipeLoaded {
                    print("recipe loaded")
                    withAnimation {
                        if let food = viewModel.recipe {
                            navigationState = .results(food)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LoadingView(linkToRecipe: .constant(""), navigationState: .constant(.loading))
        .environment(FoodViewModel())
}
