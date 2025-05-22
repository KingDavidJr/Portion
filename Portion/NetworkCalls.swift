//
//  NetworkCalls.swift
//  Portion
//
//  Created by David Amedeka on 3/6/25.
//

import Foundation


@Observable
@MainActor
class URLProcessor {
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var food = Food()
    var isRecipeLoaded: Bool = false
    
    func fetchRecipe(urlString: String) async {
        guard urlString.count > 0 else {
            return
        }
        
        guard let url = URL(string: "https://api.spoonacular.com/recipes/extract?url=\(urlString)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("38b3cb2c7f4a4f87be615bc96c566877", forHTTPHeaderField: "x-api-key")
            
        do {
            isLoading = true
            let (data, response) = try await URLSession.shared.data(for: request)
        
            if let httpResponse = response as? HTTPURLResponse , httpResponse.statusCode == 200 {
                do {
                    let decodedRecipe = try JSONDecoder().decode(Food.self, from: data)
                    food = decodedRecipe
                    isLoading = false
                    isRecipeLoaded = true
                    print("Loaded")
                } catch {
                    errorMessage = "Failed to decode recipe. \(error.localizedDescription)"
                    isLoading = false
                }
            }
            
        } catch {
            print("Failed to fetch recipe: \(error)")
            isLoading = false
        }
    }
    
}

//https://www.simplyrecipes.com/recipes/oxtail_stew/

//
