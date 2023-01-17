//
//  RecipeResult.swift
//  SpoonacularDomain
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

public struct RecipeResult {
    let results: [Recipe]
    let offset: UInt16
    let number: UInt16
    let totalResults: UInt16
    
    public init(results: [Recipe], offset: UInt16, number: UInt16, totalResults: UInt16) {
        self.results = results
        self.offset = offset
        self.number = number
        self.totalResults = totalResults
    }
}
