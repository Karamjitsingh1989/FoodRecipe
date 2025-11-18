//
//  RecipeMapper.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import Foundation

class RecipeMapper {
    
    static func mapDTOToEntity(dtos: [RecipeDTO]) -> [Recipe] {
       return dtos.map { recipeObj in
           Recipe(id: recipeObj.id,
                         name: recipeObj.name,
                         ingredients: recipeObj.ingredients.map { ingredients in return "• \(ingredients)" },
                         instructions: recipeObj.instructions.enumerated().map { index, instructions in return "\(index + 1). \(instructions)" },
                         prepTimeMinutes: "\(recipeObj.prepTimeMinutes) min",
                         cookTimeMinutes: "\(recipeObj.cookTimeMinutes) min",
                         servings: "\(recipeObj.servings)", difficulty: recipeObj.difficulty, cuisine: recipeObj.cuisine, caloriesPerServing: "\(recipeObj.caloriesPerServing) kcal", tags: recipeObj.tags, userId: "\(recipeObj.userId)", image: recipeObj.image, rating: "\(recipeObj.rating)/ 5.0", reviewCount: "\(recipeObj.reviewCount) reviews", mealType: recipeObj.mealType)
        }
    }
    
}
