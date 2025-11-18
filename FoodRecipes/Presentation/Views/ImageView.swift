//
//  ImageView.swift
//  FoodRecipes
//
//  Created by Karamjit Singh on 13/11/25.
//

import SwiftUI

struct ImageView: View {
    let imageURL: String
    var body: some View {
        AsyncImage(url: URL(string:imageURL)) { result in
            if let image =  result.image {
                image.resizable().scaledToFill().frame(height: 200).clipped().cornerRadius(8)
            }
            
        }
    }
}

#Preview {
    ImageView(imageURL: "")
}
