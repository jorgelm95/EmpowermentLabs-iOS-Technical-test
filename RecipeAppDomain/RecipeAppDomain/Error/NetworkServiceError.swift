//
//  NetworkServiceError.swift
//  SpoonacularDomain
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

public enum NetworkServiceError: Error {
    case invalidPath(message: String)
    case invalidParams(message: String)
    case serverError(response: Any)
    case decodeError(error: Error)
    case customError(message: String)
    case invalidRequest(message: String)
}
