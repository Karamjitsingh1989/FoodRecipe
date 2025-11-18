//
//  NetworkService.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import Foundation

protocol APIServiceProtocol {
    func fetchData<T: Codable>(endpoint: String, resultType:T.Type, completion: @escaping (Result<T, Error>) -> Void)
    func fetchData<T: Codable>(endpoint: String, resultType: T.Type) async throws -> T
}

class APIService: APIServiceProtocol {
    var session: URLSession
    var baseURL: String
    var reachabilty: Reachabilty
    var apiHandler:APIHandler
    var responseHander:ResponseHandler
    
    init(session: URLSession, baseURL: String, reachabilty: Reachabilty, apiHandler:APIHandler = APIHandler(), responseHander:ResponseHandler = ResponseHandler()) {
        self.session = session
        self.baseURL = baseURL
        self.reachabilty = reachabilty
        self.responseHander = responseHander
        self.apiHandler = apiHandler
    }
    
    func fetchData<T:Codable>(endpoint: String, resultType: T.Type, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        guard self.reachabilty.isNetworkReachable() else {
            completion(.failure(APIError.noInternetConnection))
            return
        }
        self.apiHandler.request(url: baseURL + endpoint) { [weak self] result in
            switch result {
                case .success(let data):
                    self?.responseHander.handleResponse(data: data, resultType: resultType, completion: completion)
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
            }
        }
    }
    
    @MainActor
    func fetchData<T:Codable>(endpoint: String, resultType: T.Type) async throws -> T  {
        guard self.reachabilty.isNetworkReachable() else {
            throw APIError.noInternetConnection
        }
        let data = try await self.apiHandler.request(url: baseURL + endpoint)
        let dataModel = try await self.responseHander.handleReponse(data: data, resultType: resultType)
        return dataModel
    }
}
