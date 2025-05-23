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
    var isRecipeLoaded: Bool = false
    var food: Food?
    
    func fetchFoodsFromRecipe(from recipeURL: String) async {
        self.isRecipeLoaded = false
        // Guard clauses to ensure a Valid URL
        guard !recipeURL.isEmpty else {
            //MARK: Handle error
            return
        }
        
        guard let url = URL(string: "https://szcaoakxuyuvtdscroaf.supabase.co/functions/v1/portion-extract-recipe?url=\(recipeURL)") else {
            //MARK: Handle error
            return
        }
        
        // Create URL Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
                    self.isRecipeLoaded = true
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
