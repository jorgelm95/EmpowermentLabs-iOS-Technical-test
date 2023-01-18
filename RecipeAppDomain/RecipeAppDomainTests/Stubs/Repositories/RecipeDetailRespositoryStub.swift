//
//  RecipeDetailRespositoryStub.swift
//  RecipeAppDomainTests
//
//  Created by Jorge Menco on 1/18/23.
//

import Foundation
import Combine

@testable import RecipeAppDomain

final class RecipeDetailRespositoryStub: RecipeDetailRepositoryType {

    private var error: NetworkServiceError?
    
    func setError(error: NetworkServiceError) {
        self.error = error
    }
    
    func getRecipeById(_ id: String) -> AnyPublisher<RecipeAppDomain.RecipeDetail, NetworkServiceError> {
        guard let error = self.error else {
            return Just(
                RecipeDetail(
                    identifier: "1",
                    title: "Pasta alpesto",
                    imageURL: URL(string: "www.alpesto.com")!,
                    imageType: .jpg,
                    summary: "Pasta with summary",
                    instructions: "Pasta with summary",
                    healthScore: "9.0",
                    pricePerServing: "11.0"))
                .setFailureType(to: NetworkServiceError.self)
                .eraseToAnyPublisher()
        }
        return Fail(error: error).eraseToAnyPublisher()
    }
}


