//
//  DetailView.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 13/11/25.
//

import SwiftUI

struct DetailView: View {
    let recipe: Recipe
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack {
                ImageView(imageURL: recipe.image).overlay(
                    VStack(alignment: .leading, spacing: 4) {
                        Text(recipe.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white).padding(.leading, 8)
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(recipe.rating) (\(recipe.reviewCount))")
                                .foregroundColor(.white)
                                .font(.subheadline)
                            Spacer()
                        }.padding(.leading,8)
                    }.background(Color.black.opacity(0.4)).clipShape(RoundedCorner(radius: 8, corners: [.bottomLeft, .bottomRight]))
                        .padding(.leading, 0).padding(.bottom, 0).padding(.trailing,0),
                    alignment: .bottomLeading
                    
                )
                HStack {
                    VStack {
                        Text("Prep")
                        Text(recipe.prepTimeMinutes).foregroundColor(.gray)
                    }
                    
                    Spacer()
                    VStack {
                        Text("Cook")
                        Text(recipe.cookTimeMinutes).foregroundColor(.gray)
                    }
                    
                    Spacer()
                    VStack {
                        Text("Serves")
                        Text(recipe.servings).foregroundColor(.gray)
                    }
                    Spacer()
                    VStack {
                        Text("Level")
                        Text(recipe.difficulty).foregroundColor(.gray)
                    }
                }.font(.subheadline).padding().background(.gray.opacity(0.05)).cornerRadius(8)
                    .padding(.top, 10).padding(.bottom, 15)
                HStack {
                    Text("INGREDIENTS").font(Font.headline.bold())
                    Spacer()
                }
                ForEach(0..<recipe.ingredients.count, id: \.self) { index in
                    HStack{
                        Text(recipe.ingredients[index]).font(.subheadline).foregroundColor(Color(.label))
                        Spacer()
                    }
                   
                }
                HStack {
                    Text("INSTRUCTIONS").font(Font.headline.bold())
                    Spacer()
                }.padding(.top, 15)
                ForEach(0..<recipe.instructions.count, id: \.self) { index in
                    HStack {
                        Text(recipe.instructions[index]).font(.subheadline).foregroundColor(Color(.label))
                        Spacer()
                    }
                }
                
                Spacer()
            }
        }.navigationTitle("Recipe Detail")
    }
}

#Preview {
    DetailView(recipe: Recipe(id: 1, name: "Pizza", ingredients: [
        "Pizza dough",
        "Tomato sauce",
        "Fresh mozzarella cheese",
        "Fresh basil leaves",
        "Olive oil",
        "Salt and pepper to taste"
      ], instructions: [
        "Preheat the oven to 475°F (245°C).",
        "Roll out the pizza dough and spread tomato sauce evenly.",
        "Top with slices of fresh mozzarella and fresh basil leaves.",
        "Drizzle with olive oil and season with salt and pepper.",
        "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
        "Slice and serve hot."
      ],prepTimeMinutes: "20",
                              cookTimeMinutes: "15", servings: "4", difficulty: "Easy", cuisine: "Italian", caloriesPerServing: "300",
                              tags: [
                                "Pizza",
                                "Italian"
                              ], userId: "166", image: "https://cdn.dummyjson.com/recipe-images/1.webp", rating: "4.6", reviewCount: "98",
                              mealType: [
                                "Dinner"
                              ]))
}
