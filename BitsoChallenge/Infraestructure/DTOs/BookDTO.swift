//
//  Book.swift
//  BitsoChallenge
//
//  Created by Junior Sancho on 3/12/21.
//  Copyright © 2021 Junior Sancho. All rights reserved.
//

import Foundation

struct BookDTO: Codable {
    let success: Bool
    let payload: BookPayload?
    
    func toBook() -> Book {
        return Book(book: payload?.book ?? "",
                    bookDetails: payload?.toBookDetails())
    }
}

struct BookPayload: Codable {
    let high: String?
    let last: String?
    let createdAt: String?
    let book: String?
    let volume: String?
    let vwap: String?
    let low: String?
    let ask: String?
    let bid: String?
    let changeTwentyFour: String
    
    enum CodingKeys: String, CodingKey {
        case high
        case last
        case createdAt = "created_at"
        case book
        case volume
        case vwap = "vwap"
        case low
        case ask
        case bid
        case changeTwentyFour = "change_24"
    }
    
    func toBookDetails() -> BookDetails {
        return BookDetails(last: last,
                           bid: bid,
                           ask: ask, low: low,
                           high: high,
                           volume: volume)
    }
}
