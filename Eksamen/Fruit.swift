//
//  Fruit.swift
//  Eksamen
//
//  Created by Lea Skagen on 11/11/2022.
//

import Foundation

struct Fruit : Decodable {
    let genus: String
    let name: String
    let id: Int
    let family: String
    let order: String
    let nutritions: Nutritions
    
    enum Keys: String, CodingKey {
        case genus
        case name
        case id
        case family
        case order
        case nutritions
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.genus = try container.decode(String.self, forKey: Keys.genus)
        self.name = try container.decode(String.self, forKey: Keys.name)
        self.id = try container.decode(Int.self, forKey: Keys.id)
        self.family = try container.decode(String.self, forKey: Keys.family)
        self.order = try container.decode(String.self, forKey: Keys.order)
        self.nutritions = try container.decode(Nutritions.self, forKey: Keys.nutritions)
        
    }
    
}

struct Nutritions : Decodable {
    let carbohydrates: Double?
    let protein: Double?
    let fat: Double?
    let calories: Double?
    let sugar: Double?
    
    enum Keys: String, CodingKey {
        case carbohydrates
        case protein
        case fat
        case calories
        case sugar
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.carbohydrates = try container.decode(Double?.self, forKey: Keys.carbohydrates)
        self.protein = try container.decode(Double?.self, forKey: Keys.protein)
        self.fat = try container.decode(Double?.self, forKey: Keys.fat)
        self.calories = try container.decode(Double?.self, forKey: Keys.calories)
        self.sugar = try container.decode(Double?.self, forKey: Keys.sugar)
    }
}
