//
//  RecipeDetailUseCaseStub.swift
//  RecipeAppUITests
//
//  Created by Jorge Menco on 1/18/23.
//

import Foundation
import Combine
@testable import RecipeAppUI
@testable import RecipeAppDomain

final class RecipeDetailUseCaseStub:BaseUseCaseStub<RecipeDetail, String>  {
    
    private var doaminError: DomainError?
    
    override func buildUseCase(params: BaseUseCase<RecipeDetail, String>.Params) -> AnyPublisher<RecipeDetail, DomainError> {
        
        if let errorResult = doaminError {
            return Fail(error: errorResult).eraseToAnyPublisher()
        } else {
            return Just(
                RecipeDetail(
                    identifier: "1",
                    title: "Pasta alpesto",
                    imageURL: URL(string: "www.alpesto.com")!,
                    imageType: .jpg,
                    summary: "Pasta with summary",
                    instructions: "Pasta with summary",
                    healthScore: "9.0",
                    pricePerServing: "11.0")
            ).setFailureType(to: DomainError.self)
            .eraseToAnyPublisher()
        }
    }
    
    func setError(error: DomainError) {
        self.doaminError = error
    }
}
