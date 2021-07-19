//
//  Payload.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/12/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import Foundation

struct AvailableBooksDTO: Codable {
    let success: Bool
    let payload: [PayloadDTO]?
}

struct PayloadDTO: Codable {
    let book: String?
    let minAmount: String?
    let maxAmount: String?
    let minPrice: String?
    let maxPrice: String?
    let minValue: String?
    let maxValue: String?
    
    enum CodingKeys: String, CodingKey {
        case book
        case minAmount = "minimum_amount"
        case maxAmount = "maximum_amount"
        case minPrice = "minimum_price"
        case maxPrice = "maximum_price"
        case minValue = "minimum_value"
        case maxValue = "maximum_value"
    }
    
    func toBook() -> Book {
        return Book(book: book)
    }
}

struct Response<T: Codable>: Codable {
    let success: Bool
    let payload: T
    
}
