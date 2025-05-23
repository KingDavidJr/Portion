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
                
                Text("Link to Recipe")
                    .padding(.horizontal)
                TextField(text: $linkToRecipe, prompt: Text("http://")) {
                    
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                }
                .padding()
                
                Text("Number of Servings")
                    .padding(.horizontal)
                
                TextField(text: $servingsCountInput, prompt: Text("Number of Servings")) {
                    
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                }
                .padding()
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
                    navigationState = .loading
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                        Text("Submit")
                            .foregroundStyle(.white)
                    }
                }
                .padding()
                .containerRelativeFrame(.vertical) { size, axis in
                    size * 0.125
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
