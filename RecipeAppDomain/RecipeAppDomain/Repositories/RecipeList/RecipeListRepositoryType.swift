//
//  RecipeListRepositoryType.swift
//  RecipeAppDomain
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation
import Combine

public protocol RecipeListRepositoryType {
    func searchRecipeByText(by query: String, page: Pagination?) -> AnyPublisher<RecipeResult, NetworkServiceError>
}
