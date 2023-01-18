//
//  RecipeResult.swift
//  SpoonacularDomain
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

public struct RecipeResult: Hashable {
  
    
    public let results: [Recipe]
    public let offset: UInt16
    public let number: UInt16
    public let totalResults: UInt16
    
    public init(results: [Recipe], offset: UInt16, number: UInt16, totalResults: UInt16) {
        self.results = results
        self.offset = offset
        self.number = number
        self.totalResults = totalResults
    }
    
    public static func == (lhs: RecipeResult, rhs: RecipeResult) -> Bool {
        return lhs.results == rhs.results &&
        lhs.number == rhs.number &&
        lhs.totalResults == rhs.totalResults &&
        lhs.offset == rhs.offset
    }
}
