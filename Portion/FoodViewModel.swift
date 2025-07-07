//
//  FoodViewModel.swift
//  Portion
//
//  Created by David Amedeka on 5/22/25.
//
import Foundation
import NetworkHandler

@MainActor
@Observable final class FoodViewModel {
    private var recipeManager: RecipeManagerProtocol
    var isLoading: Bool = false
    var isRecipeLoaded: Bool = false
    var errorMessage: String?
    var recipe: Recipe?
    
    init(recipeManager: RecipeManagerProtocol = RecipeManager()) {
        self.recipeManager = recipeManager
    }
    
    func getRecipe(from recipeURL: String) async {
        isLoading = true
        
        do {
            let fetchedRecipe = try await recipeManager.fetchRecipe(from: recipeURL)
            if fetchedRecipe != nil {
                recipe = fetchedRecipe
                isRecipeLoaded = true
                isLoading = false
            }
        } catch {
            if let error = error as? NetworkHandler.NetworkError {
                switch error {
                    case .invalidURL:
                        errorMessage = "Invalid URL"
                    case .invalidResponse:
                        errorMessage = "Invalid Response"
                    case .decodingError(let decodingError):
                        errorMessage = "Decoding Error: \(decodingError)"
                    case .httpError(statusCode: let statusCode, response: let response):
                        errorMessage = "HTTP Error: \(statusCode) \(String(describing: response))"
                    case .requestFailed(let reason):
                        errorMessage = "Request Failed: \(reason)"
                    case .otherError(let underlyingError):
                        errorMessage = "Other Error: \(underlyingError)"
                }
            }
        }
    }
}
