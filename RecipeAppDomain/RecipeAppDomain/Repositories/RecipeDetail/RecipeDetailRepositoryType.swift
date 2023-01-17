//
//  RecipeDetailRepositoryType.swift
//  SpoonacularDomain
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation
import Combine

public protocol RecipeDetailRepositoryType {
    
    func getRecipeById(_ id: String) -> AnyPublisher<RecipeDetail, NetworkServiceError>
}
