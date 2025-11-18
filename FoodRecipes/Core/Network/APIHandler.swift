//
//  APIHandler.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import Foundation

protocol RequestProtocol {
   func request(url: String, completion: @escaping(Result<Data, Error>) -> Void)
   func request(url: String) async throws -> Data
}

class APIHandler: RequestProtocol {
    
    func request(url: String, completion: @escaping (Result<Data, any Error>) -> Void) {
        guard let url = URL(string: url) else {
            return completion(.failure(APIError.invalidURL))
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let data = data else {
                return completion(.failure(APIError.noData))
            }
            completion(.success(data))
        }.resume()
    }
    
    func request(url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
}
