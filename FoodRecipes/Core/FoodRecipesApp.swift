//
//  FoodRecipesApp.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import SwiftUI

@main
struct FoodRecipesApp: App {
    private let container = DIContainer.shared
   
    init () {
        let apiService = APIService(session: URLSession.shared, baseURL: API.baseURL, reachabilty: Reachabilty()) as APIServiceProtocol
        let recipeRepository = RecipeRespositoryImpl(apiServices: apiService) as RecipeRespository
        let fetchRecipeUseCase = FetchRecipeUseCase(repository: recipeRepository) as FetchRecipeUseCaseProtocol
        container.register(APIServiceProtocol.self) { apiService }
        container.register(RecipeRespository.self) { recipeRepository }
        container.register(FetchRecipeUseCaseProtocol.self){ fetchRecipeUseCase }
    }
    var body: some Scene {
        WindowGroup {
            SplashScreen()
        }
    }
}
