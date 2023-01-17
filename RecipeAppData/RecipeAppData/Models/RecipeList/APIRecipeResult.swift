//
//  APIRecipeResult.swift
//  RecipeAppData
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

struct APIRecipeResult: Codable {
    let results: [APIRecipe]
    let offset: UInt16
    let number: UInt16
    let totalResults: UInt16
}
