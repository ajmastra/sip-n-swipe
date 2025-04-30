//
//  Cocktail.swift
//  sip-n-swipe
//
//  Created by AJ Mastrangelo on 4/29/25.
//

import Foundation

struct Cocktail: Decodable, Identifiable {
    var id: String
    let name: String
    let imageURL: String
    let category: String?
    let ingredients: [String]
    let instructions: String?


    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case imageURL = "strDrinkThumb"
        case category = "strCategory"
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strInstructions
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        instructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)


        // grab first 5 ingredients
        ingredients = [
            try container.decodeIfPresent(String.self, forKey: .strIngredient1),
            try container.decodeIfPresent(String.self, forKey: .strIngredient2),
            try container.decodeIfPresent(String.self, forKey: .strIngredient3),
            try container.decodeIfPresent(String.self, forKey: .strIngredient4),
            try container.decodeIfPresent(String.self, forKey: .strIngredient5),
        ].compactMap { $0 }
    }
    
    init(id: String, name: String, imageURL: String, category: String?, ingredients: [String], instructions: String?) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.category = category
        self.ingredients = ingredients
        self.instructions = instructions
    }

}



extension Cocktail {
    static let mock = Cocktail(
        id: "11001",
        name: "Old Fashioned",
        imageURL: "https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg",
        category: "Cocktail",
        ingredients: ["Bourbon", "Angostura bitters", "Sugar", "Water"],
        instructions: "Stir ingredients with ice, strain into glass, garnish with orange twist."
    )
}

