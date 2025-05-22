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
    @Environment(URLProcessor.self) private var urlProcessor
    @State private var linkToRecipe: String = ""
    @State private var servingsCountInput: String = ""
    @State private var servingsCount: Int = 1
    @State private var navigationState : NavigationState = .home
    
    let step = 1
    let range = 1...100
    var body: some View {
        VStack {
            switch navigationState {
            case .home:
                HomeView(linkToRecipe: $linkToRecipe, servingsCountInput: $servingsCountInput, servingsCount: $servingsCount, navigationState: $navigationState)
                    .environment(urlProcessor)
            case .loading:
                LoadingView(linkToRecipe: $linkToRecipe, navigationState: $navigationState)
            case .results(let food):
                ResultsView(food: food, wantedServings: servingsCount, goHome: resetToHome)
            }
            
        }
        .padding()
        
    }
    
    private func resetToHome() {
        navigationState = .home
        linkToRecipe = ""
        servingsCountInput = ""
        urlProcessor.isLoading = false
    }
}

#Preview {
    ContentView()
        .environment(URLProcessor())
}

//https://www.simplyrecipes.com/recipes/oxtail_stew/
