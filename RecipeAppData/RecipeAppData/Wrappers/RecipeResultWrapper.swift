//
//  RecipeResultWrapper.swift
//  SpoonacularData
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation
import RecipeAppDomain

public class RecipeResultWrapper: BaseWrapperType {
    typealias APIData = APIRecipeResult
    typealias DomainData = RecipeResult
    
    static func map(_ apiData: APIRecipeResult) throws -> RecipeResult {
        
        let recipeList = try apiData.results.compactMap { apidata in
            try RecipeWrapper.map(apidata)
        }
        
        return RecipeResult(
            results: recipeList,
            offset: apiData.offset,
            number: apiData.number,
            totalResults: apiData.totalResults)
    }
}
