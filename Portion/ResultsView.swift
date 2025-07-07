//
//  ResultsView.swift
//  Portion
//
//  Created by David Amedeka on 3/2/25.
//

import SwiftUI

struct ResultsView: View {
    var food: Recipe
    var wantedServings: Int
    
    @State private var servingsCountInput: String = ""
    @State private var showPopup = false
    @State var servings: Int
    
    var goHome: () -> Void
    
    init(food: Recipe, wantedServings: Int, goHome: @escaping () -> Void) {
        self.food = food
        self.wantedServings = wantedServings
        _servings = State(initialValue: wantedServings)
        self.goHome = goHome
    }
    var body: some View {
            VStack {
                if !food.image.isEmpty {
                    AsyncImage(url: URL(string: food.image)) {image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                }
                    Text(food.title)
                        .font(.largeTitle)
                    
                    HStack {
                        Text("Requested Servings:")
                        Button {
                            withAnimation {
                                showPopup.toggle()
                            }
                        } label: {
                            Text("\(servings)")
                        }
                    }
                    .font(.headline)
                    
                    if showPopup {
                        ServingsEntryField(_servingsCountInput: $servingsCountInput, _servings: $servings)
                            .onTapGesture {
                                // Prevent tap from dismissing when clicking box
                            }
                    }
                    
                    let multiplier = Double(servings) / Double(food.servings)
                    Spacer(minLength: 40)
                    Text("Ingredients")
                        .font(.title2)
                    ForEach(food.extendedIngredients, id: \.self) { ingredients in
                        HStack {
                            AsyncImage(url: URL(string: "https://img.spoonacular.com/ingredients_100x100/\(ingredients.image)")!) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 30, height: 30)
                            Text(ingredients.name)
                            Spacer()
                            //MARK: Do a conversion to fractions
                            let calculatedAmount = ingredients.amount * multiplier
                            let convertedAmount = String(format: "%.2f", calculatedAmount)
                            Text("\(convertedAmount) \(ingredients.unit)")
                            if ingredients.unit == "" {
                                Text("\(ingredients.name)")
                            }
                        }
                        .font(.callout)
                        .padding()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            withAnimation {
                                goHome()
                            }
                        }) {
                            Image(systemName: "chevron.left")
                        }

                }
            }
            .onTapGesture {
                withAnimation {
                    if showPopup == true {
                        showPopup = false
                    }
                    
                }
            //.toolbar(.hidden)
        }
        //.ignoresSafeArea()
    }
    
}

#Preview {
    ResultsView(food:Recipe(title: "Rice and Steak", servings: 2, extendedIngredients: [Ingredients(_id: 1, _image: "", _name: "Jasmine Rice", _amount: 1.25, _unit: "cups"), Ingredients(_id: 1, _image: "", _name: "Steak", _amount: 2.0, _unit: "lbs")]), wantedServings: 1, goHome: {} )
}

struct ServingsEntryField: View {
    @Binding var _servingsCountInput: String
    @Binding var _servings: Int
    var body: some View {
        TextField(text: $_servingsCountInput, prompt: Text("Number of Servings")) {
            
        }
        .keyboardType(.numberPad)
        .padding()
        .overlay(content: {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.black, lineWidth: 1)
        })
        .padding()
        .onChange(of: _servingsCountInput) {
            if let intValue = Int(_servingsCountInput) {
                _servings = intValue
            } else {
                _servings = 1
            }
        }
    }
}
