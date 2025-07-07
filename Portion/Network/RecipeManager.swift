//
//  RecipeManager.swift
//  Portion
//
//  Created by David Amedeka on 6/29/25.
//
import Foundation
import NetworkHandler

protocol RecipeManagerProtocol {
    func fetchRecipe(from recipeURL: String) async throws -> Recipe?
}

class RecipeManager: RecipeManagerProtocol {
    private var networkHandler: NetworkHandlerProtocol
    private var baseURL: String
    
    init(networkHandler: NetworkHandlerProtocol = NetworkHandler()){
        self.networkHandler = networkHandler
        self.baseURL = "https://szcaoakxuyuvtdscroaf.supabase.co/functions/v1/portion-extract-recipe?url="
    }
    
    func fetchRecipe(from recipeURL: String) async throws -> Recipe? {
        guard let url = URL(string: "\(baseURL)\(recipeURL)") else {
            throw NetworkHandler.NetworkError.invalidURL
        }
        
        do {
            if let data = try await networkHandler.fetchData(from: url, with: [:]) {
                let decoder = JSONDecoder()
                let recipe = try decoder.decode(Recipe.self, from: data)
                return recipe
            }
        } catch let decodingError as DecodingError {
            throw NetworkHandler.NetworkError.decodingError(decodingError)
        } catch {
            throw NetworkHandler.NetworkError.otherError(error)
        }
        return nil
    }
}
