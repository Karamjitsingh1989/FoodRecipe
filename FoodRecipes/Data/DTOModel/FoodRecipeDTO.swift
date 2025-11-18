//
//  FoodRecipeDTO.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import Foundation

struct RecipeDTO: Codable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let prepTimeMinutes: Int
    let cookTimeMinutes: Int
    let servings: Int
    let difficulty: String
    let cuisine: String
    let caloriesPerServing: Int
    let tags: [String]
    let userId: Int
    let image: String
    let rating: Double
    let reviewCount: Int
    let mealType: [String]
    enum codingKeys: String, CodingKey {
        case id, name, ingredients, instructions, prepTimeMinutes, cookTimeMinutes, servings, difficulty, cuisine, caloriesPerServing, tags, userId, image, rating, reviewCount, mealType
    }
}

struct RecipeDTOs: Codable {
    let recipes: [RecipeDTO]
}
