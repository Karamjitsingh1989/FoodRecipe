//
//  APIError.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import Foundation

enum APIError: Error {
    case noInternetConnection
    case requestFailed
    case invalidURL
    case decodingError
    case noData
}
