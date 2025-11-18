//
//  RecipeEntity.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import Foundation

struct Recipe: Identifiable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let prepTimeMinutes: String
    let cookTimeMinutes: String
    let servings: String
    let difficulty: String
    let cuisine: String
    let caloriesPerServing: String
    let tags: [String]
    let userId: String
    let image: String
    let rating: String
    let reviewCount: String
    let mealType: [String]
  
}
