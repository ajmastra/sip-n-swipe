//
//  CocktailDetailView.swift
//  sip-n-swipe
//
//  Created by AJ Mastrangelo on 4/30/25.
//

import SwiftUI

import SwiftUI

struct CocktailDetailView: View {
    let cocktail: Cocktail

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: cocktail.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                }
                .frame(height: 300)
                .clipped()
                .cornerRadius(10)

                Text(cocktail.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                if let category = cocktail.category {
                    Text("Category: \(category)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Divider()

                Text("Ingredients")
                    .font(.headline)

                ForEach(cocktail.ingredients, id: \.self) { ingredient in
                    Text("• \(ingredient)")
                }

                Divider()

                if let instructions = cocktail.instructions {
                    Text("Instructions")
                        .font(.headline)
                        .padding(.top, 8)
                    Text(instructions)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding()
        }
        .navigationTitle(cocktail.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CocktailDetailView(cocktail: .mock)
}
