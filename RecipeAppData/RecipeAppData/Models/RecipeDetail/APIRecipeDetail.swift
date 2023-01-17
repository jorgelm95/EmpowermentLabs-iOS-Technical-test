//
//  APIRecipeDetail.swift
//  RecipeAppData
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

struct APIRecipeDetail: Codable {
    var id: Int?
    var title: String?
    var image: String?
    var imageType: String?
    var summary: String?
    var instructions: String?
    var healthScore: Int?
    var pricePerServing: Double?
}
