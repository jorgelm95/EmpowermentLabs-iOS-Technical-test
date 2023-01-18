//
//  RecipeListRepository.swift
//  RecipeAppData
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation
import Combine
import RecipeAppDomain

public class RecipeListRepository {

    private let client: NetworkServiceType

    public init(client: NetworkServiceType) {
           self.client = client
    }

    private func buildEndpointWithParams(_ queryParams: [String: Any]) -> APIRequest<APIRecipeResult> {
        return APIRequest<APIRecipeResult>(
            method: .get,
            relativePath: DataConstants.relativePath,
            parameters: queryParams,
            contentType: .URLEncoded)
       }

       private func getQueryParams(for query: String, and page: Pagination?) throws -> [String: String] {
           guard let pagination = page else {
               return ["query": query, "offset": "0", "number": "\(DataConstants.numberOfRecipes)"]
           }

           guard pagination.total > pagination.offset else {
               throw NetworkServiceError.customError(message: "404")
           }

           return ["query": query, "offset": "\(pagination.offset + DataConstants.numberOfRecipes)", "number": "\(pagination.number)"]
       }

       private func mapData(_ data: APIRecipeResult) -> AnyPublisher<RecipeResult, NetworkServiceError> {
           do {
               let domainData = try RecipeResultWrapper.map(data)
               return Future { $0(.success(domainData)) }.eraseToAnyPublisher()
           } catch {
               return Fail(error: NetworkServiceError.serverError(response: error)).eraseToAnyPublisher()
           }
       }
   }

extension RecipeListRepository: RecipeListRepositoryType {
       
    public func searchRecipeByText(by query: String, page: Pagination?) -> AnyPublisher<RecipeResult, NetworkServiceError> {
            do {
                let params = try getQueryParams(for: query, and: page)
                let endpoint = self.buildEndpointWithParams(params)
                return client.request(endpoint, queue: .main, retries: 1)
                    .flatMap{ self.mapData($0) }
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
            } catch {
                return Fail(error: error as! NetworkServiceError).eraseToAnyPublisher()
            }
    }
}
