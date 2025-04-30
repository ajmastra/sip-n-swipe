//
//  MainTabView.swift
//  sip-n-swipe
//
//  Created by AJ Mastrangelo on 4/29/25.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var viewModel = CocktailViewModel()
    
    var body: some View {
        TabView {
            CardStackView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "flame")
                    Text("Discover")
                }
                .tag(0)

            SavedRecipesView(viewModel: viewModel) // (You'll build this soon)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Saved")
                }
                .tag(1)

            Text("Search View")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(2)
        }
        .tint(.primary)
    }
}

#Preview {
    MainTabView()
}

