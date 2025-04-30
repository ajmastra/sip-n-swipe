//
//  CocktailViewModel.swift
//  sip-n-swipe
//
//  Created by AJ Mastrangelo on 4/29/25.
//

import Foundation

class CocktailViewModel: ObservableObject {
    @Published var cocktails: [Cocktail] = []
    @Published var savedCocktails: [Cocktail] = []

    func fetchRandomCocktails(count: Int = 10) {
        let group = DispatchGroup()
        var results: [Cocktail] = []

        for _ in 0..<count {
            group.enter()
            guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/random.php") else {
                group.leave()
                continue
            }

            URLSession.shared.dataTask(with: url) { data, _, _ in
                defer { group.leave() }
                guard let data = data else { return }

                do {
                    let wrapper = try JSONDecoder().decode([String: [Cocktail]].self, from: data)
                    if let cocktail = wrapper["drinks"]?.first {
                        results.append(cocktail)
                    }
                } catch {
                    print("Decode error: \(error)")
                }
            }.resume()
        }

        group.notify(queue: .main) {
            self.cocktails = results
        }
    }
    
    func removeCard (_ cocktail: Cocktail) {
        guard let index = cocktails.firstIndex(where: { $0.id == cocktail.id } ) else { return }
        cocktails.remove(at: index)
    }
    
    func saveCocktail (_ cocktail: Cocktail) {
        guard !savedCocktails.contains(where: { $0.id == cocktail.id }) else { return }
        savedCocktails.append(cocktail)
    }
}

