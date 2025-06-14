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
                    Text("Enter Link to Recipe")
                        .padding(.horizontal)
                        .subTitle()
                    Text("link should start with http://")
                        .padding(.horizontal)
                        .font(.callout)
                }
                TextField(text: $linkToRecipe, prompt: Text("http://")) {
                    
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                }
                .padding()
                
                Text("Enter Number of Servings")
                    .padding(.horizontal)
                    .subTitle()
                
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
