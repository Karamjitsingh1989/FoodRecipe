//
//  RecipeUseCase.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import Foundation

protocol FetchRecipeUseCaseProtocol {
    func execute(completion: @escaping (Result<[Recipe], Error>) -> Void)
    func execute() async throws -> [Recipe]
    
}

class FetchRecipeUseCase: FetchRecipeUseCaseProtocol {
    
    private let repository: RecipeRespository
    
    init(repository: RecipeRespository) {
        self.repository = repository
    }
    func execute(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        self.repository.fetchRecipes(completion: completion)
    }
    func execute() async throws -> [Recipe] {
        let recipes = try await self.repository.fetchRecipes()
        return recipes
    }
}
