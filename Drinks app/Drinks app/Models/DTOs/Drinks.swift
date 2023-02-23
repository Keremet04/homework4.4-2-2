//
//  Drinks.swift
//  Drinks app
//
//  Created by Керемет  on 23/2/23.
//

import Foundation

struct Cocktail: Decodable{
    var drinks: [Drinks]?
}

struct Drinks: Decodable {
    var strDrink: String
    var strDrinkThumb: String?
    var strInstructions: String
}
