//
//  ContentView.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 12/11/25.
//

import SwiftUI

struct ContentView: View {
    let recipes: [Recipe]
    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
    var body: some View {
        VStack {
            NavigationStack {
                List(recipes) { recipe in
                   NavigationLink(destination: DetailView(recipe: recipe)) {
                        Text(recipe.name)
                    }
                }
            }.navigationTitle("Recipes")
        }
        .padding()
    }
}

#Preview {
    ContentView(recipes:[])
}
