//
//  RecipeListUseCase.swift
//  RecipeAppDomain
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation
import Combine

public struct SearchRecipeParams {
    public let query: String
    public let paging: Pagination?
    
    public init(query: String, paging: Pagination?) {
        self.query = query
        self.paging = paging
    }
}

public final class RecipeListUseCase: BaseUseCase<RecipeResult, SearchRecipeParams> {
    
    private let repository: RecipeListRepositoryType
    
    public init(repository: RecipeListRepositoryType) {
        self.repository = repository
    }

    public override func buildUseCase(params: SearchRecipeParams) -> AnyPublisher<RecipeResult, DomainError> {
        self.repository.searchRecipeByText(by: params.query, page: params.paging)
            .mapError {  self.handleServiceError(error: $0) }
            .eraseToAnyPublisher()
    }
    
    private func handleServiceError(error: Error) -> DomainError {
        
        guard let networkError = error as? NetworkServiceError else {
            return DomainError.custom(message: "A generic error \(error.localizedDescription)")
        }
        
        var customMessage = "Something was wrong, please retry again."

        switch networkError {
        case .customError(let message):
            if message == "404" {
                customMessage = "there are not more recipes."
            }
        default: break
        }

        return DomainError.custom(message: customMessage)
    }
}
