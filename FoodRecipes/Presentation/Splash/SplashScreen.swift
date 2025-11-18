//
//  SplashScreen.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import SwiftUI

struct SplashScreen: View {
   
    @StateObject private var viewModel = RecipeViewModel(fetchRecipeUseCase:DIContainer.shared.resolve(FetchRecipeUseCaseProtocol.self))
    @State private var isLoading: Bool = true
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
   
   var body: some View {
        if viewModel.isDataReady {
            ContentView(recipes: viewModel.recipes)
        } else {
            ZStack {
                Color.cyan.edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Recipes").font(Font.largeTitle.bold()).foregroundStyle(Color.white)
                }
            }.onAppear {
                Task {
                   viewModel.loadData()
                }
               
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }.onChange(of: viewModel.alertMessage, { oldValue, newValue in
                if oldValue != newValue {
                    alertMessage = newValue
                    showAlert = true
                }
            })
        }
    }
}

//#Preview {
//    SplashScreen()
//}
