//
//  RestClient.swift
//  RecipeAppData
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation
import Combine
import RecipeAppDomain

public class RestClient {
    
    public struct APIConstans {
        static let apiKeyValue: String = "58304811fd474fe19de0ca4ddbd14c6a"
        static let apiKeyName: String = "apiKey"
        static let contentType: String = "Content-Type"
    }
    
    private let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    private func buildAPIRequest<Response>(_ endpoint: APIRequest<Response>) throws -> URLRequest? {
        
        var request =  URLRequest(url: try getURLRequest(endpoint).url!)
        request.setValue(endpoint.contentType.rawValue, forHTTPHeaderField: APIConstans.contentType)
        request.httpBody = try getBodyRequest(endpoint)
        request.httpMethod = endpoint.method.rawValue
        
        return request
    }
    
    private func getURLRequest<Response>(_ endpoint: APIRequest<Response>) throws -> URLComponents {
        guard var urlComponents = URLComponents(string: self.baseURL + endpoint.relativePath) else {
                   let errorMessage = "Invalid baseURL: \(self.baseURL)"
                   throw NetworkServiceError.invalidPath(message: errorMessage)
               }

               guard endpoint.contentType == .URLEncoded else {
                   return urlComponents
               }

               guard let params = endpoint.parameters as? [String: String] else {
                   let errorMessage = "Invalid format params for URL encoded content type. Params: \(endpoint.parameters ?? [:])"
                   debugPrint(errorMessage)
                   throw NetworkServiceError.invalidParams(message: errorMessage)
               }

               urlComponents.queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
               urlComponents.queryItems?.append(URLQueryItem(name: APIConstans.apiKeyName, value: APIConstans.apiKeyValue))

               return urlComponents
    }
    
    private func getBodyRequest<Response>(_ endpoint: APIRequest<Response>) throws -> Data? {
        
        guard let params = endpoint.parameters, endpoint.method == .post, endpoint.contentType == .json else {
            return nil
        }
        
        let body = try? JSONSerialization.data(withJSONObject: params)
        return body
    }
    
    private func handleResponse(_ response: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let resp = response.response as? HTTPURLResponse, resp.statusCode == 200 else {
            throw NetworkServiceError.serverError(response: response.response)
        }
        return response.data
    }
}

extension RestClient: NetworkServiceType {
    
    public func request<Response: Codable>(_ endpoint: APIRequest<Response>, queue: DispatchQueue, retries: Int) -> AnyPublisher<Response, NetworkServiceError> {
        
        do {
            guard let request = try buildAPIRequest(endpoint) else {
                let errorMessage = "Invalid format params for URL encoded content type. Params: \(endpoint.parameters ?? [:])"
                debugPrint(errorMessage)
                throw NetworkServiceError.invalidRequest(message: errorMessage)
            }
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .retry(retries)
                .tryMap { try self.handleResponse($0) }
                .decode(type: Response.self, decoder: JSONDecoder())
                .mapError { error  in
                    return NetworkServiceError.decodeError(error: error)
                }.eraseToAnyPublisher()
        } catch {
            return Fail(error: error as! NetworkServiceError).eraseToAnyPublisher()
        }
    }
}
