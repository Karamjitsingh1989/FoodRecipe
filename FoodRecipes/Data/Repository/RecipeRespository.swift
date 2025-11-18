//
//  RecipeRespository.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import Foundation

protocol RecipeRespository {
    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void)
    func fetchRecipes() async throws -> [Recipe]
}

class RecipeRespositoryImpl: RecipeRespository {
  
    private let apiServices: APIServiceProtocol
    
    init(apiServices: APIServiceProtocol) {
        self.apiServices = apiServices
    }
    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        self.apiServices.fetchData(endpoint: API.Endpoints.recipes, resultType: RecipeDTOs.self) { result in
            switch result {
                case .success(let recipeDTOs):
                    let recipes = RecipeMapper.mapDTOToEntity(dtos: recipeDTOs.recipes)
                    completion(.success(recipes))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    func fetchRecipes() async throws -> [Recipe] {
        let recipeDTOs = try await self.apiServices.fetchData(endpoint: API.Endpoints.recipes, resultType: RecipeDTOs.self)
        let recipes =  RecipeMapper.mapDTOToEntity(dtos: recipeDTOs.recipes)
        return recipes
    }
}
