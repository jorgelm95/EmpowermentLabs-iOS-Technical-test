//
//  Recipe.swift
//  SpoonacularDomain
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

public struct Recipe: Codable {
    let identifier: Int?
    let title: String?
    let imageURL: String?
    let imageType: String?
    
    public init(identifier: Int?, title: String?, imageURL: String?, imageType: String?) {
        self.identifier = identifier
        self.title = title
        self.imageURL = imageURL
        self.imageType = imageType
    }
}
