//
//  FoodViewModel.swift
//  Portion
//
//  Created by David Amedeka on 5/22/25.
//
import Foundation

@Observable
@MainActor // Ensure changes to UI runs on main thread
final class FoodViewModel {
    var isLoading: Bool = false
    var food: Food?
    
    func fetchFoodsFromRecipe(from recipeURL: String) async {
        // Guard clauses to ensure a Valid URL
        guard !recipeURL.isEmpty else {
            //MARK: Handle error
            return
        }
        
        guard let url = URL(string: "https://api.spoonacular.com/recipes/extract?url=\(recipeURL)") else {
            //MARK: Handle error
            return
        }
        
        // Create URL Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("38b3cb2c7f4a4f87be615bc96c566877", forHTTPHeaderField: "x-api-key")
        
        // Handle URL Fetch Task
        do {
            self.isLoading = true // Start Loading State while code is running
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode == 200 {
                do {
                    let decodedRecipe = try JSONDecoder().decode(Food.self, from: data)
                    self.food = decodedRecipe
                    self.isLoading = false
                } catch {
                    //MARK: Handle this error
                    print(error.localizedDescription)
                    isLoading = false
                }
            }
        } catch {
            //MARK: Handle this error
            print(error.localizedDescription)
            isLoading = false
        }
    }
}
