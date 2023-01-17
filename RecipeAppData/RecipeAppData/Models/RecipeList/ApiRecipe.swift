//
//  ApiRecipe.swift
//  RecipeAppData
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

struct APIRecipe: Codable {
    let identifier: Int?
    let title: String?
    let imageURL: String?
    let imageType: String?

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case imageURL = "image"
        case title, imageType
    }
}
