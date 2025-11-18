//
//  MockAPIService.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 14/11/25.
//

import XCTest
@testable import FoodRecipes


class MockAPIService: APIServiceProtocol {
    var fetchRecipes: Result<RecipeDTOs, any Error>?
 
    func fetchData<T>(endpoint: String, resultType: T.Type, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable, T : Encodable {
        if let result = fetchRecipes {
            completion(result as! Result<T, any Error>)
        } else {
            completion(.failure(APIError.noData))
        }
    }
    @MainActor
    func fetchData<T>(endpoint: String, resultType: T.Type) async throws -> T where T : Decodable, T : Encodable {
        if let result = fetchRecipes {
            return try result.get() as! T
        } else {
            throw APIError.noData
        }
    }
}
