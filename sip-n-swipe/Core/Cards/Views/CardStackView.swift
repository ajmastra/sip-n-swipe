//
//  CardStackView.swift
//  sip-n-swipe
//
//  Created by AJ Mastrangelo on 4/29/25.
//

import SwiftUI

struct CardStackView: View {
    @StateObject var viewModel = CocktailViewModel()
    

    var body: some View {
        VStack {
            Text("Sip n Swipe")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            ZStack {
                ForEach(viewModel.cocktails.reversed(), id: \.id) { cocktail in
                    CardView(
                        cocktail: cocktail,
                        onSwipeLeft: {
                            viewModel.removeCard(cocktail)
                        },
                        onSwipeRight: {
                            viewModel.saveCocktail(cocktail)
                            viewModel.removeCard(cocktail)
                        }
                    )
                    .id(cocktail.id)
                }
            }
        }
        .onAppear {
            if viewModel.cocktails.isEmpty {
                viewModel.fetchRandomCocktails()
            }
        }
    }

}


#Preview {
    CardStackView()
}
