//
//  RecipeDetail.swift
//  SpoonacularDomain
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

public struct RecipeDetail {
    var identifier: String
    var title: String
    var imageURL: URL?
    var imageType: ImageType
    var summary: String
    var instructions: String
    var healthScore: String
    var pricePerServing: String
    
    public init(
        identifier: String,
        title: String,
        imageURL: URL,
        imageType: ImageType,
        summary: String,
        instructions: String,
        healthScore: String,
        pricePerServing: String) {
            self.identifier = identifier
            self.title = title
            self.imageURL = imageURL
            self.imageType = imageType
            self.summary = summary
            self.instructions = instructions
            self.healthScore = healthScore
            self.pricePerServing = pricePerServing
        }
}

public enum ImageType: String {
    case png
    case jpg
}
