//
//  MainTabView.swift
//  sip-n-swipe
//
//  Created by AJ Mastrangelo on 4/29/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
    
        TabView {
            Text("Swiping View")
                .tabItem{ Image(systemName: "flame")}
                .tag(0)
            
            Text("Recipe View")
                .tabItem{ Image(systemName: "list.bullet")}
                .tag(1)
            
            Text("Search View")
                .tabItem{ Image(systemName: "magnifyingglass")}
                .tag(2)
            
        }
        .tint(.primary)
    }
}

#Preview {
    MainTabView()
}
