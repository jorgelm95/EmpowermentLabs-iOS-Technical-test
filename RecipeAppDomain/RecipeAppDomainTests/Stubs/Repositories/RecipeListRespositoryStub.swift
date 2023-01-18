//
//  RecipeListRespositoryStub.swift
//  RecipeAppDomainTests
//
//  Created by Jorge Menco on 1/18/23.
//

import Foundation
import Combine

@testable import RecipeAppDomain

final class RecipeListRespositoryStub: RecipeListRepositoryType {
    
    private var error: NetworkServiceError?
    
    func setError(error: NetworkServiceError) {
        self.error = error
    }
    
    func searchRecipeByText(by query: String, page: RecipeAppDomain.Pagination?) -> AnyPublisher<RecipeAppDomain.RecipeResult, RecipeAppDomain.NetworkServiceError> {
        
        guard let error = self.error else {
            return Just(RecipeResult(
                results: [
                    Recipe(identifier: 1, title: "pasta portobello", imageURL: "www.pasta.com", imageType: ".jpg"),
                    Recipe(identifier: 2, title: "pasta alpesto 2", imageURL: "www.alpesto.com", imageType: ".png"),
                ],
                offset: 10,
                number: 10,
                totalResults: 2
                ))
                .setFailureType(to: NetworkServiceError.self)
                .eraseToAnyPublisher()
        }
        
        return Fail(error: error).eraseToAnyPublisher()
    }
}
