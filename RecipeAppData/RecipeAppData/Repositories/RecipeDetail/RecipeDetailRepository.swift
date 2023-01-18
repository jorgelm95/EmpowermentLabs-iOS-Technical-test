//
//  RecipeDetailRepository.swift
//  RecipeAppData
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation
import Combine
import RecipeAppDomain

public class RecipeDetailRepository {
    
    private let client: NetworkServiceType
    
    public init(client: NetworkServiceType) {
        self.client = client
    }
    
    private func buildEndpointForRecipeDetail(_ id: String) -> APIRequest<APIRecipeDetail> {
        let relativePath =  "\(DataConstants.endpoints.recipes)\(id)\(DataConstants.endpoints.information)"
        return APIRequest(
            method: .get,
            relativePath: relativePath,
            parameters: [:] ,
            contentType: .URLEncoded)
    }
    
    private func mapData(_ data: APIRecipeDetail) -> AnyPublisher<RecipeDetail, NetworkServiceError> {
        do {
            let domainData = try RecipeDetailWrapper.map(data)
            return Future { $0(.success(domainData)) }.eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkServiceError.serverError(response: error)).eraseToAnyPublisher()
        }
    }
}

extension RecipeDetailRepository: RecipeDetailRepositoryType {
    public func getRecipeById(_ id: String) -> AnyPublisher<RecipeDetail, NetworkServiceError> {
        
        return client.request(buildEndpointForRecipeDetail(id), queue: .main, retries: DataConstants.numberOfRetries)
            .flatMap({
                self.mapData($0)
            })
            .eraseToAnyPublisher()
    }
}
