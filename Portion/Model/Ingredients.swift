//
//  Ingredients.swift
//  Portion
//
//  Created by David Amedeka on 5/22/25.
//

struct Ingredients: Codable, Hashable, Identifiable {
    let id: Int
    let image: String
    let name: String
    let amount: Double
    let unit: String
    
    init(_id: Int, _image: String, _name: String, _amount: Double, _unit: String) {
        self.id = _id
        self.image = _image
        self.name = _name
        self.amount = _amount
        self.unit = _unit
    }
    
    init(_id: Int) {
        self.id = _id
        self.name = ""
        self.amount = 0.0
        self.unit = ""
        self.image = ""
    }
}
