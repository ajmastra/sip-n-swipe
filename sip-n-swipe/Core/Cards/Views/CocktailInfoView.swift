//
//  CocktailInfoView.swift
//  sip-n-swipe
//
//  Created by AJ Mastrangelo on 4/29/25.
//

import SwiftUI

struct CocktailInfoView: View {
    
    let cocktail: Cocktail
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8) {
            HStack {
                Text(cocktail.name)
                    .font(.title)
                    .fontWeight(.heavy)
                
                Spacer()
                
                Button {
                    withAnimation {
                        isExpanded.toggle()
                    }
                } label: {
                    Image(systemName: isExpanded ? "arrow.down.circle" : "arrow.up.circle")
                        .fontWeight(.bold)
                        .imageScale(.large)
                }
                
            }
            
            Text(cocktail.category ?? "")
                .font(.subheadline)
                .lineLimit(2)
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Ingredients:")
                        .font(.headline)
                    ForEach(cocktail.ingredients, id: \.self) { ingredient in
                            Text("- \(ingredient)")
                    }
                }
            }
            

        }
        .foregroundStyle(.white)
        .padding(.horizontal, 130)
        .padding(.bottom, 24)
        .background(
            LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
        )
    }
}

#Preview {
    CocktailInfoView(cocktail: .mock, isExpanded: .constant(true))
}

