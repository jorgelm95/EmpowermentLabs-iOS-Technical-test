//
//  DataConstants.swift
//  RecipeAppData
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

struct DataConstants {
    
    struct endpoints {
        static let listOfRecipes = "/recipes/complexSearch"
        static let recipes = "/recipes/"
        static let information = "/information"
    }
    
    static let numberOfRecipes: UInt16 = 10
    static let numberOfRetries = 1
}
