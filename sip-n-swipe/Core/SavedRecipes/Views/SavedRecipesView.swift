//
//  SavedRecipesView.swift
//  sip-n-swipe
//
//  Created by AJ Mastrangelo on 4/29/25.
//

import SwiftUI

struct SavedRecipesView: View {
    @ObservedObject var viewModel: CocktailViewModel
    @State private var searchText: String = ""
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""

    // Filtered list based on search text
    private var filteredCocktails: [Cocktail] {
        if searchText.isEmpty {
            return viewModel.savedCocktails
        } else {
            return viewModel.savedCocktails.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationView {
                List {
                    ForEach(filteredCocktails) { cocktail in
                        NavigationLink(destination: CocktailDetailView(cocktail: cocktail)) {
                            HStack(spacing: 16) {
                                AsyncImage(url: URL(string: cocktail.imageURL)) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                                VStack(alignment: .leading) {
                                    Text(cocktail.name)
                                        .font(.headline)
                                    Text(cocktail.category ?? "")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .onDelete(perform: deleteCocktail)
                }
                .navigationTitle("Saved Recipes")
                .searchable(text: $searchText)
            }

            if showToast {
                Text(toastMessage)
                    .font(.subheadline)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.black.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.bottom, 40)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }

    // Remove cocktail and trigger toast
    private func deleteCocktail(at offsets: IndexSet) {
        for index in offsets {
            let cocktail = filteredCocktails[index]
            viewModel.savedCocktails.removeAll { $0.id == cocktail.id }
            toastMessage = "\"\(cocktail.name)\" removed"
            withAnimation {
                showToast = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    showToast = false
                }
            }
        }
    }
}

#Preview {
    SavedRecipesView(viewModel: {
        let vm = CocktailViewModel()
        vm.savedCocktails = [.mock]
        return vm
    }())
}
