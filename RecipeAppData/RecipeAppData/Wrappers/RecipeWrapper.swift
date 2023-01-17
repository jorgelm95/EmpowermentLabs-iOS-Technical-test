//
//  RecipeWrapper.swift
//  SpoonacularData
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation
import RecipeAppDomain

public class RecipeWrapper: BaseWrapperType {
    typealias APIData = APIRecipe
    typealias DomainData = Recipe
    
    static func map(_ apiData: APIRecipe) throws -> Recipe {
        return Recipe(
            identifier: apiData.identifier,
            title: apiData.title,
            imageURL: apiData.imageURL,
            imageType: apiData.imageType)
    }
}
