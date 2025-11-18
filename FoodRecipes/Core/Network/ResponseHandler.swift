//
//  ResponseHandler.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import Foundation

protocol ResponseProtocol {
    func handleResponse<T: Codable>(data: Data, resultType: T.Type, completion: @escaping(Result<T, Error>) -> Void)
    func handleReponse<T: Codable & Sendable>(data: Data, resultType: T.Type) async throws -> T
}

class ResponseHandler:ResponseProtocol {
    func handleResponse<T: Codable>(data: Data, resultType: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(resultType.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(APIError.decodingError))
        }
    }
    func handleReponse<T:Codable & Sendable>(data: Data, resultType: T.Type) async throws -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(resultType.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
}
