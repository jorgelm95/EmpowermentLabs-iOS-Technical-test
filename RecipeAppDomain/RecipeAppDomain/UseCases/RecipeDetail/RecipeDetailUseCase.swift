//
//  RecipeDetailUseCase.swift
//  RecipeAppDomain
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation
import Combine


public final class RecipeDetailUseCase: BaseUseCase<RecipeDetail, String> {
    
    private let repository: RecipeDetailRepositoryType
    
    public init(repository: RecipeDetailRepositoryType) {
        self.repository = repository
    }

    public override func buildUseCase(params: String) -> AnyPublisher<RecipeDetail, DomainError> {
        self.repository.getRecipeById(params)
            .mapError { self.handleServiceError(error: $0) }
            .eraseToAnyPublisher()
    }
    
    private func handleServiceError(error: Error) -> DomainError {
        
        guard let networkError = error as? NetworkServiceError else {
            return DomainError.custom(message: "A generic error whith the server \(error.localizedDescription)")
        }
        var customMessage = "Something was wrong, please retry again."

        switch networkError {
        case .customError(let message):
            if message == "404" {
                customMessage = "The recipe was not found."
            }
        default: break
        }

        return DomainError.custom(message: customMessage)
    }
}
