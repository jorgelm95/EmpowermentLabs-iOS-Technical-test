//
//  RecipeDetail.swift
//  SpoonacularDomain
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

public struct RecipeDetail {
    public var identifier: String
    public var title: String
    public var imageURL: URL?
    public var imageType: ImageType
    public var summary: String
    public var instructions: String
    public var healthScore: String
    public var pricePerServing: String
    
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
