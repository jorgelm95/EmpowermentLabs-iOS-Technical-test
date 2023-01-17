//
//  NetworkServiceType.swift
//  RecipeAppData
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation
import Combine
import RecipeAppDomain

public protocol NetworkServiceType {
    func request<Response: Codable>(_ endpoint: APIRequest<Response>,
                           queue: DispatchQueue,
                           retries: Int) -> AnyPublisher<Response, NetworkServiceError> where Response: Decodable
}
