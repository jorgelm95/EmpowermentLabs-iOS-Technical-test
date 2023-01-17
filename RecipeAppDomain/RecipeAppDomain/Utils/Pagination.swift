//
//  Pagination.swift
//  SpoonacularDomain
//
//  Created by Jorge Menco on 1/16/23.
//

import Foundation

public struct Pagination {
    public let offset: UInt16
    public let number: UInt16
    public let total: UInt16

    public init(offset: UInt16, number: UInt16, total: UInt16) {
        self.offset = offset
        self.number = number
        self.total = total
    }
}
