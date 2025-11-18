//
//  RecipeViewModel.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import Foundation
import SwiftUI
import Combine

protocol RecipeViewModelProtocol: ObservableObject {
    var recipes: [Recipe] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var alertMessage: String { get }
    var showAlert: Bool { get }
    var isDataReady: Bool { get }   
}
@MainActor
class RecipeViewModel: RecipeViewModelProtocol {
   
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    @Published var isDataReady: Bool = false
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
   
    private let fetchRecipeUseCase: FetchRecipeUseCaseProtocol
    
    init(fetchRecipeUseCase: FetchRecipeUseCaseProtocol) {
        self.fetchRecipeUseCase = fetchRecipeUseCase
    }
    
    func loadData() {
        self.isLoading = true
        Task {
            await fetchRecipes()
        }
        
    }
   
    func fetchRecipes() async {
        
        do {
            let recipes = try await self.fetchRecipeUseCase.execute()
            self.recipes = recipes
            self.isDataReady = true
            self.isLoading = false
        } catch {
            self.isLoading = false
            if let apiError = error as? APIError {
                self.handleError(error: apiError)
            } else {
                self.errorMessage = error.localizedDescription
                self.showAlert = true
            }
        }
    }
    
    
    func fetchRecipes() {
        self.fetchRecipeUseCase.execute() { result in
            DispatchQueue.main.async {
            self.isLoading = false
            switch result {
                case .success(let recipes):
                    self.recipes = recipes
                    self.isDataReady = true
                case .failure(let error):
                    if let apiError = error as? APIError {
                        self.handleError(error: apiError)
                    } else {
                        self.errorMessage = error.localizedDescription
                        self.showAlert = true
                    }
               }
            }
        }
    }
    
    func handleError(error: APIError) {
        switch error {
            case .decodingError:
                self.alertMessage = "Failed to decode the data."
            case .invalidURL:
                self.alertMessage = "The URL provided is invalid."
            case .noData:
                self.alertMessage = "No data was returned from the server."
            case .requestFailed:
                self.alertMessage = "The request is failed. Please try again."
            default:
                self.alertMessage = "Unknown error occured. Please try again."
        }
        self.showAlert = true
    }
}
