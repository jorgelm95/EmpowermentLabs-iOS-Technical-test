//
//  BaseWrapperType.swift
//  RecipeAppData
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

protocol BaseWrapperType {
    associatedtype APIData: Codable
    associatedtype DomainData

    static func map(_ apiData: APIData) throws -> DomainData
}
