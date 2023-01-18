//
//  RecipeListUseCaseStub.swift
//  RecipeAppUITests
//
//  Created by Jorge Menco on 1/18/23.
//

import Foundation
import Combine
@testable import RecipeAppUI
@testable import RecipeAppDomain


final class RecipeListUseCaseStub:BaseUseCaseStub<RecipeResult, SearchRecipeParams>  {
    
    private var doaminError: DomainError?
    
    override func buildUseCase(params: BaseUseCase<RecipeResult, SearchRecipeParams>.Params) -> AnyPublisher<BaseUseCase<RecipeResult, SearchRecipeParams>.Response, DomainError> {
        
        if let errorResult = doaminError {
            return Fail(error: errorResult).eraseToAnyPublisher()
        } else {
            
            return Just(RecipeResult(
                results: [
                    Recipe(identifier: 1, title: "pasta portobello", imageURL: "www.pasta.com", imageType: ".jpg"),
                    Recipe(identifier: 2, title: "pasta alpesto 2", imageURL: "www.alpesto.com", imageType: ".png")
                ],
                offset: 10,
                number: 10,
                totalResults: 2)
            ).setFailureType(to: DomainError.self)
            .eraseToAnyPublisher()
        }
    }
    
    func setError(error: DomainError) {
        self.doaminError = error
    }
}
