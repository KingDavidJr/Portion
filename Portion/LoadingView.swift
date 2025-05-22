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
    @Environment(URLProcessor.self) private var urlProcessor
    var body: some View {
        VStack {
            ProgressView("Loading...")
                .progressViewStyle(.circular)
                .tint(.blue)
                .padding()
            
        }
        .onAppear {
            Task {
                await urlProcessor.fetchRecipe(urlString: linkToRecipe)
                urlProcessor.isLoading = false
                
                if urlProcessor.isRecipeLoaded {
                    withAnimation {
                        navigationState = .results(urlProcessor.food)
                    }
                }
            }
        }
    }
}

#Preview {
    LoadingView(linkToRecipe: .constant(""), navigationState: .constant(.loading))
        .environment(URLProcessor())
}
