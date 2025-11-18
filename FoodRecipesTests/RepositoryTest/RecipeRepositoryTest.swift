//
//  RecipeRepositoryTest.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 14/11/25.
//

import XCTest
@testable import FoodRecipes

class RecipeRepositoryTest: XCTestCase {
    
    var mockAPIService: MockAPIService!
    var recipeRepository: RecipeRespositoryImpl!
    
    override func setUp()  {
        super.setUp()
        mockAPIService = MockAPIService()
        recipeRepository = RecipeRespositoryImpl(apiServices: mockAPIService)
    }
    
    func testFetchRecipesSuccess() {
        let expectedRecipes: RecipeDTOs = RecipeDTOs(recipes: [ RecipeDTO(id: 1, name: "Pizza", ingredients: [
            "Pizza dough",
            "Tomato sauce",
            "Fresh mozzarella cheese",
            "Fresh basil leaves",
            "Olive oil",
            "Salt and pepper to taste"
          ], instructions: [
            "Preheat the oven to 475°F (245°C).",
            "Roll out the pizza dough and spread tomato sauce evenly.",
            "Top with slices of fresh mozzarella and fresh basil leaves.",
            "Drizzle with olive oil and season with salt and pepper.",
            "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
            "Slice and serve hot."
          ], prepTimeMinutes: 20,
                  cookTimeMinutes: 15, servings: 4, difficulty: "Easy", cuisine: "Italian", caloriesPerServing: 300,
                  tags: [
                    "Pizza",
                    "Italian"
                  ], userId: 166, image: "https://cdn.dummyjson.com/recipe-images/1.webp", rating: 4.6, reviewCount: 98,
                  mealType: [
                    "Dinner"
                  ])])
      //  let expectedRecipeEnties = RecipeMapper.mapDTOToEntity(dtos: expectedRecipes.recipes)
        let expectation = XCTestExpectation(description: "Fetch recipes from API")
        mockAPIService.fetchRecipes = .success(expectedRecipes)
        recipeRepository.fetchRecipes { result in
            switch result {
                case .success(let recipes):
                    XCTAssertEqual(recipes.count, 1)
                case .failure:
                    XCTFail("Expected to fetch recipes successfully")
            }
            expectation.fulfill()
        }
        wait(for: [expectation] , timeout: 5.0)
        
    }
    
    func testRecipeForAPIFailure()  {
        let mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockAPIService.fetchRecipes = .failure(mockError)
        let expectation = XCTestExpectation(description: "Fetch products from API failure")
        recipeRepository.fetchRecipes { result in
            switch result {
            case .success:
                XCTFail("Expected to fail but got success")
            case .failure(let error):
                    XCTAssertEqual((error as NSError).domain, "TestError")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchEmptyRecipes() {
        mockAPIService.fetchRecipes = .success(RecipeDTOs(recipes:[]))
        let expectation = XCTestExpectation(description: "Fetch empty recipes")
        recipeRepository.fetchRecipes { result in
            switch result {
                case .success(let recipes):
                    XCTAssertEqual(recipes.count, 0, "Expected no recipes")
                case .failure:
                    XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}

