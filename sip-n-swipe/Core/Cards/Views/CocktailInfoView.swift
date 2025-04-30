//
//  CocktailInfoView.swift
//  sip-n-swipe
//
//  Created by AJ Mastrangelo on 4/29/25.
//

import SwiftUI

struct CocktailInfoView: View {
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("Old Fashioned")
                    .font(.title)
                    .fontWeight(.heavy)
                
                Spacer()
                
                Button {
                    print("DEBUG: Show info here..")
                } label: {
                    Image(systemName: "arrow.up.circle")
                        .fontWeight(.bold)
                        .imageScale(.large)
                }
                
            }
            
            Text("Whiskey | Bourbon")
                .font(.subheadline)
                .lineLimit(2)
            

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
    CocktailInfoView()
}
