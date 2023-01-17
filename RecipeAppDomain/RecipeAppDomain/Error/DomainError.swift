//
//  DomainError.swift
//  RecipeAppDomain
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

public enum DomainError: Error, Equatable {
    case custom(message: String)
}
