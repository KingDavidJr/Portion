//
//  FoodModel.swift
//  Portion
//
//  Created by David Amedeka on 3/2/25.
//

struct Recipe: Decodable {
    let image: String
    let title: String
    let servings: Int
    let extendedIngredients: [Ingredients]
    
    init(image: String = "", title: String, servings: Int, extendedIngredients: [Ingredients]) {
        self.title = title
        self.servings = servings
        self.extendedIngredients = extendedIngredients
        self.image = image
    }
    
    init() {
        self.title = ""
        self.servings = 0
        self.extendedIngredients = []
        self.image = ""
    }
}
