//
//  RecipeDetailWrapper.swift
//  RecipeAppData
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation
import RecipeAppDomain

public class RecipeDetailWrapper: BaseWrapperType {
    typealias APIData = APIRecipeDetail
    typealias DomainData = RecipeDetail
    
    static func map(_ apiData: APIRecipeDetail) throws -> RecipeDetail {
        return RecipeDetail(
            identifier: String(apiData.id ?? 0),
            title: apiData.title ?? "No title",
            imageURL: URL(string: apiData.image ?? "")!,
            imageType: ImageType(rawValue: apiData.imageType ?? "") ?? .png,
            summary: apiData.summary ?? "No summary added.",
            instructions: apiData.instructions ?? "No instructions added.",
            healthScore: String(apiData.healthScore ?? 0),
            pricePerServing: String(apiData.pricePerServing ?? 0.0))
    }
}
