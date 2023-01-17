//
//  APIRequest.swift
//  RecipeAppData
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

public class APIRequest<Response> {
    public let method: APIMethod
    public let relativePath: String
    public let parameters: [String: Any]?
    public let contentType: APIContentType

    public init(method: APIMethod = .get,
                relativePath: String,
                parameters: [String: Any]? = nil,
                contentType: APIContentType = APIContentType.json)
    {
        self.method = method
        self.relativePath = relativePath
        self.parameters = parameters
        self.contentType = contentType
    }
}
