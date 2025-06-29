//
//  ContentView.swift
//  Portion
//
//  Created by David Amedeka on 3/2/25.
//

import SwiftUI

enum NavigationState {
    case home
    case loading
    case results(Food)
}

struct ContentView: View {
    @Environment(FoodViewModel.self) private var viewModel
    @State private var linkToRecipe: String = ""
    @State private var servingsCountInput: String = ""
    @State private var servingsCount: Int = 1
    @State private var navigationState : NavigationState = .home
    
    var body: some View {
        VStack {
            switch navigationState {
            case .home:
                HomeView(linkToRecipe: $linkToRecipe, servingsCountInput: $servingsCountInput, servingsCount: $servingsCount, navigationState: $navigationState)
                    .environment(viewModel)
            case .loading:
                LoadingView(linkToRecipe: $linkToRecipe, navigationState: $navigationState)
            case .results(let food):
                ResultsView(food: food, wantedServings: servingsCount, goHome: resetToHome)
            }
            
        }        
    }
    
    private func resetToHome() {
        navigationState = .home
        linkToRecipe = ""
        servingsCountInput = ""
        viewModel.isLoading = false
    }
}

#Preview {
    ContentView()
        .environment(FoodViewModel())
}

//https://www.simplyrecipes.com/recipes/oxtail_stew/
